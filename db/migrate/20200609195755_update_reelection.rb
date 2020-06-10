class UpdateReelection < ActiveRecord::Migration[5.2]
  def change
    remove_column :representatives, :re_election, :boolean
    add_column :representatives, :next_election, :string
  end
end
