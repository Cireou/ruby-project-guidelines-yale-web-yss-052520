class RemoveRepAction < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :rep_action, :text
  end
end
