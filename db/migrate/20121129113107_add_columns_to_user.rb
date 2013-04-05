class AddColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :dob, :date
  	add_column :users, :country, :string
  	add_column :users, :city, :string
  	add_column :users, :timezone, :string
  end
end
