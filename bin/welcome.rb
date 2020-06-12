require_relative '../config/environment'
class Welcome
    def self.text
        a = Artii::Base.new
        puts a.asciify('Welcome Informed Citizen')
    end
end