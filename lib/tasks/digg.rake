desc "Fetch from digg"
task :digg => :environment do
  require "nokogiri"
  require "open-uri"
  require "cgi"
  keywords = ENV['KEYWORDS'].split("_")
  business_id = ENV['BUSINESS_ID']
  keywords.each do |keyword|
    url = "http://digg.com/search?q=#{CGI.escape(keyword)}&sort=newest&digg_count=50"
    puts url
    page = Nokogiri::HTML(open(url))
    page.css(".story-item").each do |article|
      t =  article.at_css(".story-item-title").text
      l = article.at_css(".story-item-title > a")[:href]
      s = article.at_css(".story-item-teaser").text
      title = t.strip
      link = "http://digg.com#{l}"
      snippet = s.gsub(/[^\x00-\x7F]/, ' ')
      puts title
      Raw_Data.create(title: title, link: link, snippet: snippet, keyword: keyword, source: "digg", post_type: "text", business_id: business_id)
    end
  end

end

