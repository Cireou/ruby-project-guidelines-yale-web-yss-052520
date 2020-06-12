require_relative '../config/environment'

class HomePage
    @@prompt = TTY::Prompt.new

    def self.run()
        selection = "start"
        
        choices = ["Explore Representatives", "Explore Bills", "Settings", "Log Out"]
        while selection != "Log Out"
            selection = @@prompt.select("What would you like to do?", choices)
            system("clear")
            case selection
            when choices[0]
                RepPage.load_search_engine()
            when choices[1]
                BillPage.run()
            when choices[2]
                return false if !SettingPage.run() 
            when choices[3]
                return false
            end
            system("clear")
        end
    end

end