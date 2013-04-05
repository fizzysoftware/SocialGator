class BusinessesController < ApplicationController
  before_filter :correct_user, except: ['social_profile', 'twitter_callback', 'facebook_callback']
  before_filter :find_user_businesses, :only => ['show','edit','update','social_profile','destroy','remove_twitter','remove_facebook']

  # GET /businesses/new
  # GET /businesses/new.json
  def new
    @business = Business.new  if signed_in?
    1.times {@business.keywords.build}
    @business.post_times.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business }
    end
  end

  # GET /businesses/1/edit
  def edit
    @business.post_times.build
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = @user.businesses.build(params[:business])
    respond_to do |format|
      if @business.save
        session[:current_business] = @business.id
        format.html { redirect_to root_path, notice: 'Business was successfully created.' }
        format.json { render json: @business, status: :created, location: @business }
      else
        format.html { render action: "new" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /businesses/1
  # PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update_attributes(params[:business])
        session[:current_business] = @business.id
        format.html { redirect_to scheduled_posts_path( @business), notice: 'Business was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Business was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  
  # Add social profiles

  def social_profile
    session[:current_business] = @business.id
  end

  def twitter_callback
    @business = Business.find(session[:current_business])
    auth = request.env["omniauth.auth"]
    @business.twitter_token = auth["credentials"]["token"]
    @business.twitter_secret = auth["credentials"]["secret"]
    
    if @business.save
      flash[:notice] = "Twitter account added successfully."
      redirect_to social_profile_path(current_user, @business)
    else
      render "social_profile"
    end

  end

  def remove_twitter
    @business.update_attributes(:twitter_token => " ", :twitter_secret => " ")
        session[:current_business] = @business.id
    redirect_to social_profile_path(current_user, @business)
  end

  def remove_facebook
    @business.update_attributes(:facebook_uid => " ", :facebook_token => " ", :facebook_token_expiry => " ", :facebook_page_access_token => " ", :facebook_page_id => " ")
    session[:current_business] = @business.id
    redirect_to social_profile_path(current_user, @business)
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