class PasswordResetsController < ApplicationController
  def new
  end


  def create
    user = User.find_by_email(params[:password_reset][:email])
    user.send_password_reset if user
    redirect_to login_path, notice: "Email sent with password reset instructions."
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 10.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to login_path, :notice => "Password has been reset. Please login."
    else
      render :edit
    end
  end

  
end
