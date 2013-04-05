desc "Fetch from google blog search"
task :google_blog_search => :environment do
  require "nokogiri"
  require "open-uri"
  require "cgi"
  keywords = ENV['KEYWORDS'].split("_")
  puts keywords
  business_id = ENV['BUSINESS_ID']
  keywords.each do |keyword|
    url = "https://www.google.com/search?tbm=blg&q=#{CGI.escape(keyword)}&ned=us"
    page = Nokogiri::HTML(open(url))
    page.css("li.g").each do |article|
      title =  article.at_css("h3.r > a").text
      new_title = title.chars.select{|i| i.valid_encoding?}.join
      puts new_title.encoding.name
      
      link = article.at_css("h3.r > a")[:href].split('=')[1]
      snippet = article.at_css(".s").text.split('http:')[0]
      puts new_title
      Raw_Data.create(title: new_title, link: link, snippet: snippet, keyword: keyword, source: "google_blog_search", business_id: business_id)
    end
  end

end
