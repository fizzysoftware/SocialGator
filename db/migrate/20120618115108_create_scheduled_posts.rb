class CreateScheduledPosts < ActiveRecord::Migration
  def change
    create_table :scheduled_posts do |t|
      t.string :content
      t.string :sources
      t.date :publish_date
      t.integer :business_id
      
      t.timestamps
    end
  end
end
