require_relative '../config/environment'
tp.set :max_width, 100

class BillPage
    @@prompt = TTY::Prompt.new

    def self.run()
        while true 
            bill = load_searcher()
            return if !bill
            bill.display_bill()
            if @@prompt.yes?("Would you like to explore more stats?")
                system("clear")
                load_additional_stats(bill)
            else 
                system("clear")
            end            
            request = @@prompt.yes?("Would you like to keep searching?")
            return if !request
        end
    end

    private 

    def self.load_searcher()
        bill_id = nil
        while !bill_id 
            bill_id = @@prompt.ask("Please give a bill id (usually of the form hres-###, hjres-###, sres-###, sjres-###) or a number (returns based on database order).")
            bill = Bill.find(bill_id) || Bill.find_by(bill_id: bill_id)
            return bill if bill

            choice = @@prompt.yes?("Unable to find bill, press b to go back or c to continue.")
            return false if choice == "b"
        end

    end

    def self.load_additional_stats(bill)
        choices = ["Bill Amendments", "Bill Cosponsors", "Vote Distribution", "Bill Votes","Go Back"]
        choice = @@prompt.select("What would you like to do?", choices)
        while choice != choices[4]
            case choice
            when choices[0]
                bill.load_amendments()
            when choices[1]
                bill.cosponsors()
            when choices[2]
                bill.group_votes()
            when choices[3]
                bill.votes()
            end
            delay()
            system("clear")
            choice = @@prompt.select("What would you like to do?", choices)
        end
        system("clear")
    end

    

    def self.delay()
        request = @@prompt.keypress("Press b to go back.")
        while request != "b"
            request = @@prompt.keypress("Press b to go back.")
        end
        request
        system("clear")
    end
end