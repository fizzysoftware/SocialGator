class Business < ActiveRecord::Base

  include FetchGoogleNews
  include FetchTopsy
  include FetchYoutubePost
  include FetchPinterestPost
  include FetchQuoraPost
  include FetchFlickrPost

  require "nokogiri"
  require "open-uri"
  require "cgi"

  validates :business_name, :description,:keywords, presence: true

  belongs_to :user

  has_one :facebook_page
  
  #associations
  has_many :keywords, dependent: :destroy
  accepts_nested_attributes_for :keywords, :reject_if => lambda { |a| a[:token].blank? }, :allow_destroy => true
  
  has_many :scheduled_posts, dependent: :destroy

  has_many :post_times, dependent: :destroy
  accepts_nested_attributes_for :post_times, :reject_if => lambda { |a| a[:time].blank? }, :allow_destroy => true

  has_attached_file :photo,
    :styles => {
          :thumb => "55x55#",
          :medium  => "100x100#"}, :default_url => "/assets/default_business.png"


  #Methods for fetching posts, defined in modules in lib directory.
  after_create :fetch_google_news_posts,
               :fetch_topsy_posts,
               :fetch_youtube_posts,
               :fetch_pinterest_posts,
               :fetch_quora_posts,
               :fetch_flickr_posts

  after_update :fetch_google_news_posts,
               :fetch_topsy_posts,
               :fetch_youtube_posts,
               :fetch_pinterest_posts,
               :fetch_quora_posts,
               :fetch_flickr_posts
  
end