class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.date   :birthday
      t.string :nickname
      t.string :description
      t.integer :follower_number
      t.integer :followering_number
    end
  end
end


      
