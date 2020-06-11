require_relative '../config/environment'

class HomePage
    @@prompt = TTY::Prompt.new

    def self.run()
        selection = "start"
        
        choices = ["My Representative","Explore Representatives", "Explore Bills", "Settings", "Log Out"]
        while selection != "Log Out"
            selection = @@prompt.select("What would you like to do?", choices)
            case selection
            when choices[0]
                # display_representative()
            when choices[1]
                # load_reps()
            when choices[2]
                # load_bills()  
            when choices[3]
                # binding.pry
                return false if !SettingPage.run()
            when choices[4]
                return false
            end
            system("clear")
        end
    end

end