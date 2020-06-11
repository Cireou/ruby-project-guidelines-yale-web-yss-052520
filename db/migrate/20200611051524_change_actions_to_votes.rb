class ChangeActionsToVotes < ActiveRecord::Migration[5.2]
  def change
    rename_table :actions, :votes
  end
end
