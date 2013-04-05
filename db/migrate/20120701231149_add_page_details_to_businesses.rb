class AddPageDetailsToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :facebook_page_name, :string
    add_column :businesses, :facebook_page_access_token, :string
    add_column :businesses, :facebook_page_id, :string
  end
end
