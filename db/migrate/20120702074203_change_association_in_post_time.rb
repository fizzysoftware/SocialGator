class ChangeAssociationInPostTime < ActiveRecord::Migration
  def change
    rename_column :post_times, :user_id, :business_id
  end
end
