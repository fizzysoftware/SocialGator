Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'XNCuRTmA7cBI5ecPFePV6A', 'UbxbqtOCVBMjuPX1riRtwMI2VdQfJW2btACdZJvY'
  provider :facebook, "#{APP_CONFIG['FB_APP_ID']}", "#{APP_CONFIG['FB_SECRET']}", :scope => 'email, user_birthday, read_stream, manage_pages, publish_stream'
end

#Rails.application.config.middleware.use OmniAuth::Builder do
 # provider :facebook, '357061961033826', '4201f0a5137c33bbd4752d62d0c10163', :scope => 'email, user_birthday, read_stream, manage_pages, publish_stream'
#end