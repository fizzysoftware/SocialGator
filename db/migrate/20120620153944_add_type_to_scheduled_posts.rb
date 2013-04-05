class AddTypeToScheduledPosts < ActiveRecord::Migration
  def change
    add_column :scheduled_posts, :type, :string

  end
end
