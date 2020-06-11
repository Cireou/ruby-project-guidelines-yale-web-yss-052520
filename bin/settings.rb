class Settings
    @@prompt = TTY::Prompt.new

    def self.run(user)
        choices = ["View Settings", "Change Settings"]
        selection = @@prompt.select("What would you like to do?", choices)
        case selection
        when choices[0]
            @@prompt.
        when choices[1]

        end
    end


    private 

    
end