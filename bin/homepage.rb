require_relative '../config/environment'
class HomePage
    @@prompt = TTY::Prompt.new

    def self.run()
        choices = ["My Representative","Explore Representatives", "Explore Bills", "Log Out"]
        selection = @@prompt.select("What would you like to do?", choices)
        case selection
        when choices[0]
            display_representative()
        when choices[1]
            load_reps()
        when choices[2]
            load_bills()  
        else      
            continue
        end
    end

    private

    def self.display_representative()
    end

    def self.load_bills()
    end

    def self.load_reps()
        
    end
end