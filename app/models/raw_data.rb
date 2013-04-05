class Raw_Data < ActiveRecord::Base
  attr_accessible :title, :link, :snippet, :thumbnail_url, :embed_url, :post_type, :keyword, :source, :business_id
  validates :title, :link, uniqueness: true
end