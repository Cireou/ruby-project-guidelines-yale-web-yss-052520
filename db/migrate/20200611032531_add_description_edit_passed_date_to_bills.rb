class AddDescriptionEditPassedDateToBills < ActiveRecord::Migration[5.2]
  def change
    add_column :bills, :roll_call_num, :integer 
    add_column :bills, :description, :string 
    add_column :bills, :session_num, :integer 

    rename_column :bills, :date_pass_reject, :decision_date
    change_column :bills,  :decision_date, :string
    
    rename_column :bills, :passed, :decision 
    change_column :bills, :decision, :string
  end
end
