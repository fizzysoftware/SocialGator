class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :token
      t.integer :business_id
      t.timestamps
    end
  end
end
