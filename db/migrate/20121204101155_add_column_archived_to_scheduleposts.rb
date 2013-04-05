class AddColumnArchivedToScheduleposts < ActiveRecord::Migration
  def change
  	add_column :scheduled_posts, :archived, :boolean, :default => "0"
  end
end
