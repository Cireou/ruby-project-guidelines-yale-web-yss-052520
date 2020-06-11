require_relative '../config/environment'
class HomePage
    @@prompt = TTY::Prompt.new

    def self.run(user)
        choices = ["My Representative","Explore Representatives", "Explore Bills", "Settings", "Log Out"]
        selection = @@prompt.select("What would you like to do?", choices)
        case selection
        when choices[0]
            display_representative()
        when choices[1]
            load_reps()
        when choices[2]
            load_bills()  
        when choices[3]
            Settings.run(user)
        else      
            continue
        end
    end

end