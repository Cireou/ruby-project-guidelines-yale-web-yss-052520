class ChangeBillIdColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :votes, :bill_id, :integer
  end
end
