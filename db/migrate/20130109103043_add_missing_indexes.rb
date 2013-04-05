class AddMissingIndexes < ActiveRecord::Migration
      def self.up
        add_index :businesses, :user_id
        add_index :scheduled_posts, :business_id
        add_index :keywords, :business_id
      end

      def self.down
        remove_index :businesses, :user_id
        remove_index :scheduled_posts, :business_id
        remove_index :keywords, :business_id
      end
end