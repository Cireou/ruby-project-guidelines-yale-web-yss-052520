class Action < ActiveRecord::Base 
    belongs_to :bill 
    belongs_to :representative
end