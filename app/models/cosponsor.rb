class Cosponsor < ActiveRecord::Base 
    belongs_to :representative
    belongs_to :bill
end