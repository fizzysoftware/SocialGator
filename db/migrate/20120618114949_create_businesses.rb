class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :twitter_handle
      t.string :facebook_page
      t.integer :user_id
      t.timestamps
    end
  end
end
