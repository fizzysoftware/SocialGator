class AddBusinessNameToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :business_name, :string

  end
end
