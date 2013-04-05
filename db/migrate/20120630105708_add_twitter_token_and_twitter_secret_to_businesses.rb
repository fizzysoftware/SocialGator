class AddTwitterTokenAndTwitterSecretToBusinesses < ActiveRecord::Migration
  def change
  	add_column :businesses, :twitter_token, :string
  	add_column :businesses, :twitter_secret, :string
  end
end
