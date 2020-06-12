require_relative '../config/environment'
class RepPage 
    @@prompt = TTY::Prompt.new
    def self.load_search_engine()
        while true 
            rep = load_searcher()
            return if !rep

            load_profile(rep)
            return if !load_extra_info(rep)
        end
    end

    private

    def self.load_searcher()
        rep = nil
        while !rep 
            rep_name = @@prompt.ask("Who would you like to look for (First Name + Last Name?)")
            rep = Representative.find_by(name: rep_name)
            # binding.pry
            if !rep 
                system("clear")
                request = @@prompt.yes?("Could not find that representative, would you like to look for another or try again?")
                # binding.pry
                return if !request
            end
            system("clear")
        end
        rep
    end

    def self.load_profile(rep)
        puts "Name: #{rep[:name]}"
        puts "Age: #{rep[:age]}"
        puts "Years of Experience: #{rep[:experience]}"
        puts "Party: #{getparty(rep[:party])}"
        puts "State Abbreviation: #{rep[:state]}"
        puts "Next Election: #{rep[:next_election]}"
    end

    def self.load_extra_info(rep)
        choices = ["View Votes", "View Sponsored Bills", "View Cosponsored Bills", "Go Back"]
        selection = @@prompt.select("What would you like to do?", choices)
        while selection != choices[3]
            case selection
            when choices[0]
                get_votes(rep)
            when choices[1]
                get_sponsored_bills(rep)
            when choices[2]
                get_cosponsored_bills(rep)
            end
            selection = @@prompt.select("What would you like to do?", choices)
        end
        system("clear")
        false 
    end

    def self.getparty(party_string)
        case party_string
        when "R"
            return "Republican"
        when "D"
            return "Democrat"
        when "I"
            return "Independent"
        end
    end

    def self.get_votes(rep)
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT b.title, v.vote
            FROM bills as b 
            INNER JOIN votes as v 
            ON  b.id = v.bill_id
            WHERE v.representative_id = ?")
        tp sql.execute(rep.rep_id)
        sql.close
        delay()
    end

    def self.get_sponsored_bills(rep)
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT b.title, b.bill_id, b.summary
            FROM bills as b 
            INNER JOIN representatives as r
            ON r.rep_id = b.sponsor
            WHERE r.rep_id = ?")
        tp sql.execute(rep.rep_id)
        sql.close
        delay()
    end

    def self.get_cosponsored_bills(rep)
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT b.title, b.bill_id, r2.name as Sponsor, r2.party as Party
             FROM cosponsors as c
             INNER JOIN representatives as r
             ON r.rep_id = c.rep_id
             INNER JOIN bills as b
             ON  b.id = c.bill_id
             INNER JOIN representatives AS r2
             ON r2.rep_id = b.sponsor
             WHERE c.rep_id = ?
             ")
        tp sql.execute(rep.rep_id)
        sql.close
        delay()
    end

    def self.delay()
        request = @@prompt.keypress("Press b to go back.")
        while request != "b"
            request = @@prompt.keypress("Press b to go back.")
        end
        system("clear")
    end
end