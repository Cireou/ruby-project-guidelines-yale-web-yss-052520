class CreateAmendments < ActiveRecord::Migration[5.2]
  def change
    create_table :amendments do |t|
      t.string :decision 
      t.string :decision_date
      t.integer :roll_call_num
      t.string :description
      t.integer :session_num
      t.string :bill_id
    end
  end
end
