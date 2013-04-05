class AddColumnToSchedulePosts < ActiveRecord::Migration
  def change
  	add_column :scheduled_posts, :starred, :boolean, :default => "0"
  end
end
