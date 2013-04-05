desc "Fetch from flickr"
task :flickr => :environment do
  require "fleakr"
  require 'json'
  require 'net/http'
  Fleakr.api_key = 'e437010247bb99bb4d31eab39b4e8acb'
  #def shorten(snippet, wordcount=30) 
   # snippet.split[0..(wordcount-1)].join(" ") +(snippet.split.size > wordcount ? "..." : "") 
  #end
  
  keywords = ENV['KEYWORDS'].split("_")
  business_id = ENV['BUSINESS_ID']
  keywords.each do |keyword|
    photos = Fleakr.search(keyword)
    photos.each_with_index do |photo, index|
      url = "http://api.embed.ly/1/oembed?key=884e264721944865b0dfc43b37832798&url=#{photo.url}&width=300&chars=100"
      resp = Net::HTTP.get_response(URI.parse(url))
      data = resp.body
      result = JSON.parse(data)
      title =  result["title"] || ""
      link = photo.url
      thumbnail_url = result["thumbnail_url"]
      embed_url = result["url"]
      #snippet = shorten(result["description"])
      break if index > 20
    
  
      puts title
     Raw_Data.create(title: title, link: link, snippet: "", keyword: keyword, thumbnail_url: thumbnail_url, embed_url: embed_url, post_type: "image", source: "flickr", business_id: business_id)
      break if index > 30
    end
  end

end

