desc "Fetch from Topsy"
task :topsy => :environment do
  require "nokogiri"
  require "open-uri"
  require "cgi"
  require "json"
  require "net/http"
  keywords = ENV['KEYWORDS'].split("_")
  business_id = ENV['BUSINESS_ID']
  keywords.each do |keyword|
    url = "http://otter.topsy.com/search.json?q=#{CGI.escape(keyword)}&window=dynamic&perpage=30"
    puts url
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    result = JSON.parse(data)
    puts result["response"]["list"].count
    result["response"]["list"].each do |item|
      title = item["title"]
      link = item["url"]
      Raw_Data.create(title: title, link: link, snippet: "", keyword: keyword, post_type: "text", source: "topsy", business_id: business_id)
    end

  end
  

end

