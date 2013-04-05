class AddBusinessIdToRawData < ActiveRecord::Migration
  def change
    add_column :raw_data, :business_id, :integer

  end
end
