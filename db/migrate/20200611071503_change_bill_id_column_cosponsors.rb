class ChangeBillIdColumnCosponsors < ActiveRecord::Migration[5.2]
  def change
    change_column :cosponsors, :bill_id, :integer
  end
end
