require "open-uri"
class ContentController < ApplicationController
  include ContentHelper
  before_filter :correct_user
  before_filter :find_user_businesses, :only =>['scheduled_posts','textual','images','videos','post_now','post_image_now']
  @@run = false
  
  def scheduled_posts
    @scheduled_post = @business.scheduled_posts.build
    @scheduled_text_posts = @business.scheduled_posts.paginate(:page => params[:page], :per_page => 20,:conditions => ["post_type = 'text'"])
    @scheduled_image_posts = @business.scheduled_posts.paginate(:page => params[:page], :per_page => 20,:conditions => ["post_type = 'image'"])
    @scheduled_video_posts = @business.scheduled_posts.paginate(:page => params[:page], :per_page => 20,:conditions => ["post_type = 'video'"])
    @scheduled_archived_posts = @business.scheduled_posts.where("archived =? or publish_date <?",true,Time.now + Time.zone_offset(Time.now.zone)).order("publish_date desc")
    @scheduled_starred_posts = @business.scheduled_posts.where("starred =? ",true).order("publish_date desc")
  end

  def textual
    source = params[:source] ? params[:source] : :google_news
    @content = Raw_Data.where(business_id: @business.id, source: source, post_type: "text")
    @scheduled_post = @business.scheduled_posts.build 
    respond_to do |format|
      format.html { @@run = false }
      format.js
    end
  end

  def images
    source = params[:source] ? params[:source] : :pinterest
    @content = Raw_Data.where(business_id: @business.id, source: source, post_type: "image")
    @scheduled_post = @business.scheduled_posts.build  
    respond_to do |format|
        format.html { @@run = false }
        format.js
    end
      
  end

  def videos
    source = params[:source] ? params[:source] : :youtube
    @content = Raw_Data.where(business_id: @business.id, source: source, post_type: "video")
    @scheduled_post = @business.scheduled_posts.build   
    respond_to do |format|
        format.html { @@run = false }
        format.js
    end
    
  end

  private

    def find_user_businesses
        @business = Business.find_by_id(params[:id])
        redirect_to root_url if @business.nil?
    end

    def correct_user
      @user = User.find_by_id(params[:user_id])
      redirect_to root_path unless current_user?(@user)
    end

end