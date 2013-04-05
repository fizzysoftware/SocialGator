class ChangePublishDateInScheduledPosts < ActiveRecord::Migration
  def change
    change_column(:scheduled_posts, :publish_date, :datetime)
  end
end
