class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t| 
      t.text :rep_action
      t.integer :bill_id 
      t.integer :representative_id
    end
  end
end
