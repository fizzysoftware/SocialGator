desc "Fetch from youtube"
task :youtube => :environment do
  require "open-uri"
  require "youtube_search"
  require 'json'
  require 'net/http'
  require "cgi"
  
  keywords = ENV['KEYWORDS'].split("_")
  business_id = ENV['BUSINESS_ID']
  keywords.each do |keyword|
    urls = []
    YoutubeSearch.search("#{CGI.escape(keyword)}", :per_page => 20).each do |video|
      url =  "http://youtube.com/watch?v=#{video['video_id']}"
      urls << url
    end
    escaped_urls = urls.collect {|u| "#{CGI.escape(u)}"}.join(",")  
    p escaped_urls
    url = "http://api.embed.ly/1/oembed?key=884e264721944865b0dfc43b37832798&urls=#{escaped_urls}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    result = JSON.parse(data)
    result.each do |res|
      link = res["url"]
      title =  res["title"]
      thumbnail_url = res["thumbnail_url"]
      embed_url = res["html"]
      snippet = res["description"]
    
      Raw_Data.create(title: title, link: link, snippet: snippet, keyword: keyword, thumbnail_url: thumbnail_url, embed_url: embed_url, post_type: "video", source: "youtube", business_id: business_id)
    end
  end
end

