class CreateCosponsors < ActiveRecord::Migration[5.2]
  def change
    create_table :cosponsors do |t| 
      t.string :bill_id
      t.string :rep_id
    end
  end
end
