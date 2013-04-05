class StaticPagesController < ApplicationController
  def home
    redirect_to [current_user, @resume] if signed_in?
  end

  def about
  end

  def toc
  end

  def privacy
  end

  def faq
  end
  
  def comingsoon
  end
end
