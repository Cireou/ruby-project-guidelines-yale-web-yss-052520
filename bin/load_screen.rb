require_relative '../config/environment'

class LoadScreen

    @@prompt = TTY::Prompt.new
       
    def self.run()
        load_choice = @@prompt.select("What would you like to do?", ["Log In","Sign Up", "Quit"])
        system("clear")
        case load_choice
        when "Log In"
            Runner.user = load_login()
        when "Sign Up"
            Runner.user = load_signup()
        else
            puts "Bye Bye"
            exit()
        end
    end

    def self.load_login()
        username = @@prompt.ask("What is your username?")
        password = @@prompt.mask("What is your password?")
        user = User.find_by(username: username, password: password)
        system("clear")
        if !user
            choice = @@prompt.select("You don't have an account, what would you like to do?", ["Sign Up", "Quit"])
            case choice
            when "Sign Up"
                load_signup()
                system("clear")
            else 
                exit()
            end
        end
        user
    end

    def self.load_signup()
        username = get_signup_username()
        password = get_signup_password()
        address = get_signup_address()
        system("clear")
        User.create(username: username, password:password, address: address)
    end
    
    def self.get_signup_username()
        username = @@prompt.ask("Choose a username.")
        while (User.find_by(username: username))
            system("clear")
            username = @@prompt.ask("That username already exists, please choose another.")
        end
        username
    end
    
    def self.get_signup_password()
        password = @@prompt.mask("Choose a password.")
        verify_pass = @@prompt.mask("Please re-type your password.")
    
        while password != verify_pass
            system("clear")
            puts("The passwords don't match!")
            password = @@prompt.mask("Choose a password?")
            verify_pass = @@prompt.mask("Please re-type your password.")
        end
        password 
    end
    
    def self.get_signup_address()
        address = @@prompt.ask("What is your address?")
        #TODO: Verify address exists
    end
end