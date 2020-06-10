class Bill < ActiveRecord::Base 
    has_many :actions 
    has_many :representatives, through: :actions
end