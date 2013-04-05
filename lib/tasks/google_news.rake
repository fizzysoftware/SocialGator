desc "Fetch from google news"
task :google_news => :environment do
  require "nokogiri"
  require "open-uri"
  require "cgi"
  keywords = ENV['KEYWORDS'].split("_")
  business_id = ENV['BUSINESS_ID']
  keywords.each do |keyword|
    url = "http://news.google.com/?q=#{CGI.escape(keyword)}&ned=us"
    page = Nokogiri::HTML(open(url))
    page.css(".esc-body").each do |article|
      title =  article.at_css(".esc-lead-article-title").text
      link = article.at_css(".esc-lead-article-title > a")[:href]
      snippet = article.at_css(".esc-lead-snippet-wrapper").text
      puts title
      Raw_Data.create(title: title, link: link, snippet: snippet, keyword: keyword, post_type: "text", source: "google_news", business_id: business_id)
    end
  end

end

