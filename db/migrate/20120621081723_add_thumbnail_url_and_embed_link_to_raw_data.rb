class AddThumbnailUrlAndEmbedLinkToRawData < ActiveRecord::Migration
  def change
    add_column :raw_data, :thumbnail_url, :string
    add_column :raw_data, :embed_url, :string
  end
end
