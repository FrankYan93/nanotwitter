class CreateFollowerfollowings < ActiveRecord::Migration
  def change
    create_table :followerfollowings do |t|
      t.integer :user_id
      t.integer :followed_user_id
      t.datetime   :follow_date
    end
  end
end
