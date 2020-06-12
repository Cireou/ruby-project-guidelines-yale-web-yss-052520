require_relative '../config/environment'
tp.set :max_width, 200

class BillPage
    @@prompt = TTY::Prompt.new

    def self.run()
        while true 
            bill = load_searcher()
            return if ! bill
            display_bill(bill)
            load_additional_stats(bill) if @@prompt.yes?("Would you like to explore more stats?")
            
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

    def self.display_bill(bill)
        puts "Title: #{bill.title}"
        puts "Sponsor: #{get_sponsor_name(bill.sponsor)}"
        puts "Date Proposed: #{bill.date_proposed}"
        puts "Summary: #{bill.summary}"
        puts "Link: #{bill.link}"
    end

    def self.load_additional_stats(bill)
        choices = ["Bill Amendments", "Bill Cosponsors", "Vote Distribution", "Bill Votes","Go Back"]
        choice = @@prompt.select("What would you like to do?", choices)
        while choice != choices[4]
            case choice
            when choices[0]
                load_amendments(bill)
            when choices[1]
                cosponsors(bill)
            when choices[2]
                group_votes(bill)
            when choices[3]
                votes(bill)
            end
            system("clear")
            choice = @@prompt.select("What would you like to do?", choices)
        end
        system("clear")
    end

    def self.load_amendments(bill)
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT a.description, a.decision, a.decision_date
            FROM amendments as a
            WHERE a.bill_id = ?")
        tp sql.execute(bill.id)
        sql.close
        delay()
    end

    def self.cosponsors(bill)
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT r.name, r.age, r.party, r.rep_id
            FROM cosponsors as c INNER JOIN representatives as r
            ON c.rep_id = r.rep_id
            WHERE c.bill_id = ?")
        tp sql.execute(bill.id)
        sql.close
        delay()
    end

    def self.votes(bill)
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT r.name, r.party, v.vote
            FROM representatives as r INNER JOIN votes as v
            ON r.rep_id = v.representative_id
            WHERE v.bill_id = ?")
        tp sql.execute(bill.id)
        sql.close
        delay()
    end

    def self.group_votes(bill)
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT r.party, v.vote, Count(*) as Total
            FROM representatives as r INNER JOIN votes as v
            ON r.rep_id = v.representative_id
            WHERE v.bill_id = ?
            GROUP BY r.party, v.vote")
        tp sql.execute(bill.id)
        sql.close
        delay()
    end

    def self.delay()
        request = @@prompt.keypress("Press b to go back.")
        while request != "b"
            request = @@prompt.keypress("Press b to go back.")
        end
        request
        system("clear")
    end

    def self.get_sponsor_name(sponsor_ID)
        rep = Representative.find_by(rep_id: sponsor_ID)
        return rep ? rep.name : rep 
    end
end