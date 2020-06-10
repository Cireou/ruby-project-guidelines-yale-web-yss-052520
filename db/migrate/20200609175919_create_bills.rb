class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t| 
      t.string :title
      t.date :date_proposed 
      t.boolean :passed
      t.date :date_pass_reject
      t.text :summary 
      t.string :link
    end
  end
end
