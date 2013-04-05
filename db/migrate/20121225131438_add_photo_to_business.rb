class AddPhotoToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :photo_file_name, :string
    add_column :businesses, :photo_content_type, :string
    add_column :businesses, :photo_file_size, :integer
  end
end
