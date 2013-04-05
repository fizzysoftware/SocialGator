desc "Publish scheduled posts"
task :publish => :environment do
  ScheduledPost.where("publish_date <= ? ", Time.now).each do |post|
    post.publish
  end
end

