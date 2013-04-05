class SessionsController < ApplicationController
  def new
    redirect_to current_user if current_user
    # render template
  end
  
  def create
    user = User.find_by_email(params[:sessions][:email])
    if user && user.authenticate(params[:sessions][:password])
      sign_in user
      flash[:notice] = "Signin successful"
      redirect_to user
    else
      flash.now[:error] = "Invalid credentials. Please try again."
      render "new"
    end
    
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end