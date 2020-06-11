require_relative '../config/environment'
class RepPage 
    @@prompt = TTY::Prompt.new
    def self.load_search_engine()
        while true 
            rep = load_searcher()
            return if !rep

            load_profile(rep)
            return if !load_extra_info()
        end
    end

    def self.load_my_rep()
        user = User.find(Runner.user.id)
        my_rep = APICALL(user.zipcode)#API call to find rep
        rep = load_rep(my_repname)
    end

    private

    def self.load_searcher()
        rep = nil
        while !rep 
            rep_name = @@prompt.ask("Who would you like to look for (First Name + Last Name?)")
            rep = Representative.find_by(name: rep_name)
            # binding.pry
            if !rep 
                system("clear")
                request = @@prompt.yes?("Could not find that representative, would you like to look for another or try again?")
                # binding.pry
                return if !request
            end
            system("clear")
        end
        rep
    end

    def self.load_profile(rep)
        puts "Name: #{rep[:name]}"
        puts "Age: #{rep[:age]}"
        puts "Years of Experience: #{rep[:experience]}"
        puts "Party: #{getparty(rep[:party])}"
        puts "State Abbreviation: #{rep[:state]}"
        puts "Next Election: #{rep[:next_election]}"
    end

    def self.load_extra_info()
        
    end

    def self.getparty(party_string)
        case party_string
        when "R"
            return "Republican"
        when "D"
            return "Democrat"
        when "I"
            return "Independent"
        end
    end
end