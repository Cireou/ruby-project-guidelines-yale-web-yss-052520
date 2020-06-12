class Bill < ActiveRecord::Base
    has_many :amendments
    
    has_many :votes
    has_many :representative, through: :votes

    has_many :cosponsors
    has_many :representatives, through: :cosponsors

    def display_bill()
        puts "Title: #{self.title}"
        puts "Sponsor: #{get_sponsor_name(self.sponsor)}"
        puts "Date Proposed: #{self.date_proposed}"
        puts "Summary: #{self.summary}"
        puts "Link: #{self.link}"
    end

    def load_amendments()
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT a.description, a.decision, a.decision_date
            FROM amendments as a
            WHERE a.bill_id = ?")
        tp sql.execute(self.id)
        sql.close
    end

    def cosponsors()
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT r.name, r.age, r.party, r.rep_id
            FROM cosponsors as c INNER JOIN representatives as r
            ON c.rep_id = r.rep_id
            WHERE c.bill_id = ?")
        tp sql.execute(self.id)
        sql.close
    end

    def votes()
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT r.name, r.party, v.vote
            FROM representatives as r INNER JOIN votes as v
            ON r.rep_id = v.representative_id
            WHERE v.bill_id = ?")
        tp sql.execute(self.id)
        sql.close
    end

    def group_votes()
        sql = ActiveRecord::Base.connection.raw_connection.prepare(
            "SELECT r.party, v.vote, Count(*) as Total
            FROM representatives as r INNER JOIN votes as v
            ON r.rep_id = v.representative_id
            WHERE v.bill_id = ?
            GROUP BY r.party, v.vote")
        tp sql.execute(self.id)
        sql.close
    end
    
    private 
    
    def get_sponsor_name(sponsor_ID)
        rep = Representative.find_by(rep_id: sponsor_ID)
        return rep ? rep.name : rep 
    end
end