class AlterBills < ActiveRecord::Migration[5.2]
  def change
    add_column :bills, :sponsor, :string

    remove_column :bills, :decision, :string
    remove_column :bills, :decision_date, :string
    remove_column :bills, :roll_call_num, :integer 
    remove_column :bills, :description, :string 
    remove_column :bills, :session_num, :integer
  end
end
