class AddEmbedUrlAndThumbnailUrlToScheduledPosts < ActiveRecord::Migration
  def change
    add_column :scheduled_posts, :thumbnail_url, :string
    add_column :scheduled_posts, :embed_url, :string
    add_column :raw_data, :type, :string
  end
end
