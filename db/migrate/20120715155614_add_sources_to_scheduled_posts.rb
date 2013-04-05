class AddSourcesToScheduledPosts < ActiveRecord::Migration
  def change
    add_column :scheduled_posts, :publish_sources, :string, default: "all"

  end
end
