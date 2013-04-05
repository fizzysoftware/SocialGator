class AddPostTimeToScheduledPost < ActiveRecord::Migration
  def change
  	add_column :scheduled_posts, :post_after_minutes,:integer
  end
end
