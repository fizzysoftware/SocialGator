class ContactUsController < ApplicationController
  #skip_before_filter :authenticate_user!
  def new
    @contact_u = ContactU.new

  end

  def create
    @contact_u = ContactU.new(params[:contact_u])
    @contact_u.user_id = session[:user_id]
    UserMailer.contact_us(@contact_u).deliver
    respond_to do |format|
      if @contact_u.save
        format.html { redirect_to(new_contact_u_path, :notice => 'We will contact you soon.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
