class AddBillIdToBills < ActiveRecord::Migration[5.2]
  def change
    add_column :bills, :bill_id, :string 
  end
end
