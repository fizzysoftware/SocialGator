class UsersController < ApplicationController
  before_filter :signed_in_user, :only => ['show']
  before_filter :correct_user, :only => ['show','edit','update','change_password','update_password','destroy']
  
  # GET /users/1
  # GET /users/1.json
  def show
    @businesses = @user.businesses
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save       
        format.html do
          sign_in @user
          flash[:notice] = "Welcome to SocialApp!"
          #UserMailer.welcome_message(@user).deliver
          redirect_to @user
        end
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
   
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html do
          sign_in @user
          flash[:notice] = "Your profile was updated successfully"
          redirect_to @user
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_password   
  end

  def update_password
     if params[:user][:password] == params[:user][:old_password]
      @user.update_attribute(:password,params[:user][:password])
       flash[:notice] = 'Password updated successfully.'
       redirect_to :controller => "users",:action => "edit",:id => @user.id
     else
        flash[:notice] = 'Password does not match.'
        redirect_to :controller => "users",:action => "edit",:id => @user.id
     end
  end

  def facebook_callback
    auth = request.env["omniauth.auth"]

    me = FbGraph::User.me(auth["credentials"]["token"])

    me.accounts.each do |account|
      @page = FacebookPage.new
      @page.user_id = current_user.id
      @page.facebook_uid = auth["uid"]
      @page.facebook_page_access_token = account.access_token
      @page.facebook_page_id = account.identifier
      @page.facebook_page_name = account.name
      @page.save
    end
    flash[:notice] = "Facebook account added successfully."
    redirect_to root_path
  end

  def social_accounts
  end


    private
    def correct_user
        @user = User.find_by_id(params[:id])
        redirect_to root_path unless current_user?(@user)
    end
end