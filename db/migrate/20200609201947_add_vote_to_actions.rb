class AddVoteToActions < ActiveRecord::Migration[5.2]
  def change
    add_column :actions, :vote, :string
  end
end
