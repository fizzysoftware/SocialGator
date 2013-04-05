class CreatePostTimes < ActiveRecord::Migration
  def change
    create_table :post_times do |t|
      t.datetime :time
      t.integer :user_id
      t.timestamps
    end
  end
end
