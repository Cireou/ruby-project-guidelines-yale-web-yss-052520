class CreateRepresentatives < ActiveRecord::Migration[5.2]
  def change
    create_table :representatives do |t| 
      t.string :name 
      t.integer :age
      t.integer :experience
      t.string :district
      t.string :party 
      t.boolean :re_election
    end
  end
end
