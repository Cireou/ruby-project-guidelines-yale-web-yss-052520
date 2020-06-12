require_relative '../config/environment'

class SettingPage
    @@prompt = TTY::Prompt.new

    def self.run()
        user = User.find(Runner.user.id)
        choices = ["View Settings", "Change Settings", "Delete Account", "Go Back"]
        selection = @@prompt.select("What would you like to do?", choices)
        # binding.pry
        system("clear")
        while true
            case selection
            when choices[0]
                display_settings()
            when choices[1]
                change_settings()
            when choices[2]
                return delete_account()
            when choices[3]
                system("clear")
                return false 
            end
            system("clear")
            selection = @@prompt.select("What would you like to do?", choices)
        end
    end

    private 

    def self.display_settings()
        user = User.find(Runner.user.id)
        system("clear")
        key = "c"
        while key != "b"
            puts "Username: #{user.username}"
            puts "Password: #{user.password}"
            key = @@prompt.keypress("Press c to continue or b to go back.")
            system("clear")
        end
    end

    def self.change_settings()
        user = User.find(Runner.user.id)
        system("clear")
        choices = ["Change Username", "Change Password", "Go Back"]
        selection = @@prompt.select("What would you like to do?", choices)
        while selection != choices[2]
            case selection
            when choices[0]
                Runner.user.update(username: LoadScreen.get_signup_username)
            when choices[1]
                Runner.user.update(password: LoadScreen.get_signup_password)
            end 
            # binding.pry
            system("clear")
            selection = @@prompt.select("What would you like to do?", choices)
        end
        system("clear")
    end   

    def self.delete_account()
        # binding.pry
        User.delete(Runner.user.id)
        system("clear")
        return false 
    end

    
end

