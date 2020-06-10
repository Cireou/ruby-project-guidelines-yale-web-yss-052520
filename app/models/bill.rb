class Bill < ActiveRecord::Base 
    self.primary_key = :bill_id
    has_many :actions 
    has_many :representatives, through: :actions
end