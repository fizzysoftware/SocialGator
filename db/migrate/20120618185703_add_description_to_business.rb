class AddDescriptionToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :description, :text
    change_column :scheduled_posts, :content, :text
  end
end
