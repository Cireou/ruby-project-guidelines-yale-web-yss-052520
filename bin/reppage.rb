require_relative '../config/environment'
class RepPage 
    @@prompt = TTY::Prompt.new
    def self.load_search_engine()
        while true 
            rep = load_searcher()
            return if !rep

            rep.load_profile()
            return if !load_extra_info(rep)
        end
    end

    private

    def self.load_searcher()
        rep = nil
        while !rep 
            rep_name = @@prompt.ask("Who would you like to look for (First Name + Last Name?)")
            rep = Representative.find_by(name: rep_name)
            if !rep 
                system("clear")
                request = @@prompt.yes?("Could not find that representative, would you like to look for another or try again?")
                return if !request
            end
            system("clear")
        end
        rep
    end

    def self.load_extra_info(rep)
        choices = ["View Votes", "View Sponsored Bills", "View Cosponsored Bills", "Go Back"]
        selection = @@prompt.select("What would you like to do?", choices)
        while selection != choices[3]
            case selection
            when choices[0]
                rep.get_votes()
            when choices[1]
                rep.get_sponsored_bills()
            when choices[2]
                rep.get_cosponsored_bills()
            end
            delay()
            selection = @@prompt.select("What would you like to do?", choices)
        end
        system("clear")
        false 
    end

    
    def self.delay()
        request = @@prompt.keypress("Press b to go back.")
        while request != "b"
            request = @@prompt.keypress("Press b to go back.")
        end
        system("clear")
    end
end