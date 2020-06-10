class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t| 
      t.text  :username 
      t.text  :password 
      t.text :address 
    end
  end
end
