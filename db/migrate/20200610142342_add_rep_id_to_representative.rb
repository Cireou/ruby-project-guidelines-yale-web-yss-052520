class AddRepIdToRepresentative < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :rep_id, :string 
  end
end
