desc "Fetch from pinterest"
task :pinterest => :environment do
  require "open-uri"
  require "nokogiri"
  require 'json'
  require 'net/http'
  require "cgi"
  
  keywords = ENV['KEYWORDS'].split("_")
  business_id = ENV['BUSINESS_ID']
  keywords.each do |keyword|
    url = "http://pinterest.com/search/?q=#{CGI.escape(keyword)}"
    page = Nokogiri::HTML(open(url))
    page.css(".pin").each_with_index do |pin, index|
      pin_url = "http://pinterest.com#{pin.at_css('.PinImage')[:href]}"
      url = "http://api.embed.ly/1/oembed?key=884e264721944865b0dfc43b37832798&url=#{pin_url}&maxwidth=500"
      resp = Net::HTTP.get_response(URI.parse(url))
      data = resp.body
      result = JSON.parse(data)
      title =  result["title"] || ""
      link = pin_url
      thumbnail_url = result["thumbnail_url"]
      embed_url = result["url"]
      snippet = result["description"]

      puts title
      Raw_Data.create(title: title, link: link, snippet: snippet, keyword: keyword, thumbnail_url: thumbnail_url, embed_url: embed_url, post_type: "image", source: "pinterest", business_id: business_id)
      break if index > 20
    end
  end
end

