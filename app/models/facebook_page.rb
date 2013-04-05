class FacebookPage < ActiveRecord::Base
   	attr_accessible :user_id, :facebook_uid, :facebook_page_name, :facebook_page_access_token,:facebook_page_id

  	belongs_to :user
  	belongs_to :business
end
