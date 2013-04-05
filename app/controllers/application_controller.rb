class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  require 'rake'

  def call_rake(task, keywords = [], business_id)
    system "/usr/bin/rake #{task} KEYWORDS=\"#{keywords.join('_')}\" BUSINESS_ID=\"#{business_id}\" --trace 2>&1 >> #{Rails.root}/log/rake.log &"
  end
end