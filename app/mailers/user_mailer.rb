class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_message(user)
    @user = user
    mail from: "SocialGator", to: user.email, subject: "Welcome to SocialGator"
  end

  def password_reset(user)
    @user = user
    mail from: "SocialGator", to: user.email, subject: "SocialGator - Password Reset"   
  end

  def contact_us(contact_us)
    @contact_us = contact_us
    mail(:to => "nikhilk@fizzysoftware.com", :from => @contact_us.email,:subject => "Contact Us Email")
  end

end