class ScheduledPost < ActiveRecord::Base
  belongs_to :business
  validates :title, presence: true
  validates :link, presence: true
  
  after_save :publish_to_facebook_at_publish_date
  after_save :publish_to_twitter_at_publish_date

  def publish_to_facebook_at_publish_date
    unless self.business.facebook_page_id.blank?
        page = FacebookPage.find_by_id(self.business.facebook_page_id)
        graph = Koala::Facebook::GraphAPI.new(page.facebook_page_access_token)
        graph.put_wall_post("", {:name => self.title, :link => self.link,:description => self.content,:picture => self.thumbnail_url})
    end
  end

  def publish_to_twitter_at_publish_date
    unless self.business.twitter_token.blank?
        Twitter.configure do |config|
          config.consumer_key = APP_CONFIG['tw_consumer_key']
          config.consumer_secret = APP_CONFIG['tw_consumer_secret']
          config.oauth_token = self.business.twitter_token
          config.oauth_token_secret = self.business.twitter_secret
        end    
        Twitter.update(self.link)
    end
  end

  def post_to_fb_now
    unless self.business.facebook_page_id.blank?
        page = FacebookPage.find_by_id(self.business.facebook_page_id)
        graph = Koala::Facebook::GraphAPI.new(page.facebook_page_access_token)
        graph.put_wall_post("", {:name => self.title, :link => self.link,:description => self.content,:picture => self.thumbnail_url})
    end
  end

  def post_to_twitter_now
    unless self.business.twitter_token.blank?
        Twitter.configure do |config|
          config.consumer_key = APP_CONFIG['tw_consumer_key']
          config.consumer_secret = APP_CONFIG['tw_consumer_secret']
          config.oauth_token = self.business.twitter_token
          config.oauth_token_secret = self.business.twitter_secret
        end    
        Twitter.update(self.link)
    end
  end

  handle_asynchronously :publish_to_facebook_at_publish_date, :run_at => Proc.new { |i| i.post_after_minutes.minutes.from_now }
  
  handle_asynchronously :publish_to_twitter_at_publish_date, :run_at => Proc.new { |i| i.post_after_minutes.minutes.from_now }

  handle_asynchronously :post_to_fb_now, :priority => 20

  handle_asynchronously :post_to_twitter_now, :priority => 19

end