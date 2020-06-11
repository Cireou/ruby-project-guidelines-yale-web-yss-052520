class Bill < ActiveRecord::Base
    has_many :amendments
    
    has_many :votes
    has_many :representative, through: :votes

    has_many :cosponsors
    has_many :representatives, through: :cosponsors
end