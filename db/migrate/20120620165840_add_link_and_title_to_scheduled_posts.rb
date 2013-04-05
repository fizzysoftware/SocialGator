class AddLinkAndTitleToScheduledPosts < ActiveRecord::Migration
  def change
    add_column :scheduled_posts, :link, :string
    add_column :scheduled_posts, :title, :string

  end
end
