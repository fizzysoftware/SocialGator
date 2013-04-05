class CreateRawData < ActiveRecord::Migration
  def change
    create_table :raw_data do |t|
      t.text :snippet
      t.string :link
      t.string :title
      t.string :source
      t.string :keyword

      t.timestamps
    end
  end
end
