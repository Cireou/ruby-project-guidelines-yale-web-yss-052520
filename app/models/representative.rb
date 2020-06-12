class Representative < ActiveRecord::Base 
    self.primary_key = :rep_id
    has_many :votes
    has_many :bills, through: :votes

    has_many :cosponsors
    has_many :bills, through: :cosponsors

    def load_profile()
        puts "Name: #{self.name}"
        puts "Age: #{self.age}"
        puts "Years of Experience: #{self.experience}"
        puts "Party: #{getparty(self.party)}"
        puts "State Abbreviation: #{self.state}"
        puts "Next Election: #{self.next_election}"
    end

    def get_votes()
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT b.title, v.vote
            FROM bills as b 
            INNER JOIN votes as v 
            ON  b.id = v.bill_id
            WHERE v.representative_id = ?")
        tp sql.execute(self.rep_id)
        sql.close
    end

    def get_sponsored_bills()
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT b.title, b.bill_id, b.summary
            FROM bills as b 
            INNER JOIN representatives as r
            ON r.rep_id = b.sponsor
            WHERE r.rep_id = ?")
        tp sql.execute(self.rep_id)
        sql.close
    end

    def get_cosponsored_bills()
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
        tp sql.execute(self.rep_id)
        sql.close
    end

    private

    def getparty(party_string)
        case party_string
        when "R"
            return "Republican"
        when "D"
            return "Democrat"
        when "I"
            return "Independent"
        end
    end
end