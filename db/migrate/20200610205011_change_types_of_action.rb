class ChangeTypesOfAction < ActiveRecord::Migration[5.2]
  def change
    change_column :actions, :bill_id, :string 
    change_column :actions, :representative_id, :string
  end
end
