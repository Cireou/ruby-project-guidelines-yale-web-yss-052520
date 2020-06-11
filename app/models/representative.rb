class Representative < ActiveRecord::Base 
    self.primary_key = :rep_id
    has_many :votes
    has_many :bills, through: :votes

    has_many :cosponsors
    has_many :bills, through: :cosponsors
end