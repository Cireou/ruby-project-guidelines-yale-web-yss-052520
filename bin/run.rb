require_relative '../config/environment'
require_all 'bin'
User.destroy_all()

class Runner
    mattr_accessor :user 

    def self.run 
        while true 
            @@user = LoadScreen.run()
            display_home_page = true  
            while display_home_page
                display_home_page =  HomePage.run()
            end
        end
    end
end
system("clear")
Picture.Text()
Welcome.text()
Runner.run()


