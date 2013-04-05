class AddFacebookCredentialsToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :facebook_uid, :string
    add_column :businesses, :facebook_token, :string
    add_column :businesses, :facebook_token_expiry, :datetime
  end
end
