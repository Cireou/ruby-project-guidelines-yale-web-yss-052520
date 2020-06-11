require_relative '../config/environment'

class SettingPage
    @@prompt = TTY::Prompt.new

    def self.run()
        user = User.find(Runner.user.id)
        choices = ["View Settings", "Change Settings", "Delete Account", "Go Back"]
        selection = @@prompt.select("What would you like to do?", choices)
        # binding.pry
        while selection != choices[2]
            case selection
            when choices[0]
                display_settings(user)
            when choices[1]
                change_settings(user)
            when choices[2]
                return delete_account()
            end
            system("clear")
            selection = @@prompt.select("What would you like to do?", choices)
        end
    end

    private 

    def self.display_settings(user)
        system("clear")
        key = "c"
        while key != "b"
            puts "Username: #{user.username}"
            puts "Password: #{user.password}"
            puts "Address: #{user.address}"
            key = @@prompt.keypress("Press c to continue or b to go back.")
            system("clear")
        end
    end

    def self.change_settings(user)
        system("clear")
        choices = ["Change Username", "Change Password", "Change Address", "Go Back"]
        selection = @@prompt.select("What would you like to do?", choices)
        while selection != choices[3]
            case selection
            when choices[0]
                Runner.user.update(username: LoadScreen.get_signup_username)
            when choices[1]
                Runner.user.update(password: LoadScreen.get_signup_password)
            when choices[2]  
                Runner.user.update(address: LoadScreen.get_signup_address)
            end 
            binding.pry
            system("clear")
            selection = @@prompt.select("What would you like to do?", choices)
        end
    end   

    def self.delete_account()
        User.delete(Runner.user.id)
        return false 
    end

    
end

