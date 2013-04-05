class RenameTypeToPostType < ActiveRecord::Migration
  def change
    rename_column :scheduled_posts, :type, :post_type
    rename_column :raw_data, :type, :post_type
  end
end
