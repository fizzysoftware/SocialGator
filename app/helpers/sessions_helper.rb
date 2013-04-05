module SessionsHelper
  def sign_in(user)
     cookies.permanent[:remember_token] = user.remember_token
     current_user = user
   end

   def current_user=(user)
     @current_user = user
   end

   def current_user
     @current_user ||= user_from_remember_token
   end
   
   def current_user?(user)
     current_user == user
   end

   def sign_out
     cookies.delete(:remember_token)
   end

   def signed_in?
     !current_user.nil?
   end

   def store_location
     cookies[:return_to] = request.fullpath
   end

   private
     def user_from_remember_token
       User.find_by_remember_token(cookies[:remember_token]) unless cookies[:remember_token].nil?
     end

     def signed_in_user
       unless signed_in?
         store_location
         redirect_to login_path, notice: "Please login to make changes."
       end
     end

end
