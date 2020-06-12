require_relative '../config/environment'
class Picture

    def self.Text 

        puts "|".colorize(:blue) + ("|".colorize(:blue)) * 87 + "O".colorize(:red)*95 + "|".colorize(:red) + "\n"+ ("|".colorize(:blue)+ ("*".colorize(:white) + "||".colorize(:blue))*29 + "O".colorize(:red)*95 + "|".colorize(:red) + "\n" +
        ("|".colorize(:blue) + ("|".colorize(:blue)) * 87 + "O".colorize(:red)*95 + "|".colorize(:red) + "\n") +
        "|".colorize(:blue)+ ("||".colorize(:blue) + "*".colorize(:white))*29 + ":".colorize(:white)*95 + "|".colorize(:white) + "\n" +
        ("|".colorize(:blue) + ("|".colorize(:blue)) * 87 + ":".colorize(:white)*95 + "|".colorize(:white) + "\n"))*3 +
        "|".colorize(:blue)+ ("*".colorize(:white) + "||".colorize(:blue))*29 + "O".colorize(:red)*95 + "|".colorize(:red) + "\n" + 
        "|".colorize(:blue) + ("|".colorize(:blue)) * 87 + "O".colorize(:red)*95 + "|".colorize(:red) + "\n" + 
        "|".colorize(:blue) + ("|".colorize(:blue)) * 87 + "O".colorize(:red)*95 + "|".colorize(:red) + "\n" + 
        ((( ("|".colorize(:white)) + ":".colorize(:white)*182 + "|".colorize(:white) + "\n")) * 2 +
        ("|".colorize(:red) + "O".colorize(:red)*182 + "|".colorize(:red) + "\n") * 2 ) * 3
        

    end
end

Picture.Text()

    