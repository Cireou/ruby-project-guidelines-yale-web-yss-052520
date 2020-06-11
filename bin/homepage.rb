require_relative '../config/environment'
class HomePage
    @@prompt = TTY::Prompt.new

    def self.run()
        choices = ["My Representative","Explore Representatives", "Explore Bills", "Edit Settings", "Log Out"]
        selection = @@prompt.select("What would you like to do?", choices)
        case selection
        when choices[0]
            display_representative()
        when choices[1]
            load_reps()
        when choices[2]
            load_bills()  
        when choices[3]
            load_settings()
        else      
            continue
        end
    end

    private

    def self.display_representative()
    end

    def self.load_bills()
    end

    def self.load_settings()
    end

    def self.load_reps()
        
    end
end