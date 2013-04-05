class CreateContactUs < ActiveRecord::Migration
  def self.up
    create_table :contact_us do |t|
      t.integer :user_id
      t.string :phone_number
      t.string :email
      t.string :related_to
      t.text :message
      t.text :reply_content
			t.integer :status, :default=>1
      t.timestamps
    end
  end

  def self.down
    drop_table :contact_us
  end
end
