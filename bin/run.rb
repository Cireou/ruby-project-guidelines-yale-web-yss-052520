require_relative '../config/environment'
require_all "bin"
require 'pry'

User.destroy_all()

while true
    user = LoadScreen.run() 
    while true 
        HomePage.run()
    end
end

# binding.pry
#0


