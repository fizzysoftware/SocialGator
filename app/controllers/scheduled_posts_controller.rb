class ScheduledPostsController < ApplicationController

  before_filter :find_businesses,:except => ['show','mark_as_starred','mark_as_unstarred','mark_as_archived']
  before_filter :find_scheduled_posts, :only => ['edit','update','destroy','mark_as_starred','mark_as_unstarred','mark_as_archived']
  before_filter :correct_user,:except => ['mark_as_starred','mark_as_archived']

  def edit 
  end

  def create
    if params[:scheduled_post][:post_type] == ""
        params[:scheduled_post][:post_type] = "text"
    end
    publish_date = params[:scheduled_post][:publish_date]
    params[:scheduled_post][:post_after_minutes] = ((publish_date.to_time - DateTime.now)/60).round - 330
    @scheduled_post = @business.scheduled_posts.build(params[:scheduled_post])
    respond_to do |format|
      if @scheduled_post.save
        format.html { redirect_to scheduled_posts_path(@user, @business), notice: 'Scheduled post was successfully created.' }
        format.json { render json: user_business_scheduled_posts(@user, @business), status: :created, location: @scheduled_post }
      else
        format.html { render action: "new" }
        format.json { render json: @scheduled_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scheduled_posts/1
  # PUT /scheduled_posts/1.json
  def update
    if params[:scheduled_post][:post_type] == ""
        params[:scheduled_post][:post_type] = "text"
    end
    publish_date = params[:scheduled_post][:publish_date]
    params[:scheduled_post][:post_after_minutes] = ((publish_date.to_time - DateTime.now)/60).round - 330 
    respond_to do |format|
      if @scheduled_post.update_attributes(params[:scheduled_post])
        format.html { redirect_to scheduled_posts_path(@user, @business), notice: 'Scheduled post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scheduled_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scheduled_posts/1
  # DELETE /scheduled_posts/1.json
  def destroy
    @scheduled_post.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to scheduled_posts_path(@user, @business) }
    end
  end

  # Mark the scheduled post as Starred and Unstarred
  def mark_as_starred
    if @scheduled_post.starred == false
      @scheduled_post.update_attribute(:starred, true)
      render :json => {:name => 'true'} 
     else
      @scheduled_post.update_attribute(:starred, false)
      render :json => {:name => 'false'}
     end 
  end

  # Mark the scheduled post as archived
  def mark_as_archived
    @scheduled_post.update_attribute(:archived, true)
    @scheduled_post.delay.post_to_fb_now
    @scheduled_post.delay.post_to_twitter_now
    render :json => {:name => 'true'} 
  end

  private
    def correct_user
      @user = User.find_by_id(params[:user_id])
      redirect_to root_path unless current_user?(@user)
    end

    def find_scheduled_posts
      @scheduled_post = ScheduledPost.find_by_id(params[:id])
      redirect_to root_url if @scheduled_post.nil?
    end

    def find_businesses
      @business = Business.find_by_id(params[:business_id])
      redirect_to root_url if @business.nil?
    end
end