require_relative '../config/environment'
class RepPage 
    @@prompt = TTY::Prompt.new
    def self.load_search_engine()
        rep = nil
        while !rep 
            rep_name = @@prompt.ask("Who would you like to look for (First Name + Last Name?)")
            rep = Representative.find_by(name: rep_name)
            if !rep 
                request = @@prompt.yes?("Could not find that representative, would you like to look for another or try again?")
                return if request == 'n'
            end
            load_rep_page(rep)

        end
    end

    def self.load_my_rep()
        user = User.find(Runner.user.id)
        my_rep = APICALL(user.zipcode)#API call to find rep
        rep = load_rep(my_repname)
    end

    private
    def self.load_rep_page(rep)

    end
end