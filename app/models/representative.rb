class Representative < ActiveRecord::Base 
    self.primary_key = :rep_id
    has_many :actions 
    has_many :bills, through: :actions 

end