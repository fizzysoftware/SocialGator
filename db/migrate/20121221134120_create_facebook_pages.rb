class CreateFacebookPages < ActiveRecord::Migration
  def change
    create_table :facebook_pages do |t|
    	t.integer :user_id
    	t.string :facebook_uid
    	t.string :facebook_page_name
    	t.string :facebook_page_access_token
    	t.string :facebook_page_id

      	t.timestamps
    end
  end
end
