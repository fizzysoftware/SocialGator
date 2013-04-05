desc "Fetch from quora"
task :quora => :environment do
  require "nokogiri"
  require "open-uri"
  require "cgi"
  require 'net/http'

  
  keywords = ENV['KEYWORDS'].split("_")
  business_id = ENV['BUSINESS_ID']
  keywords.each do |keyword|
    board = keyword
    url = "http://quora.com/#{board}/"
    begin
      webpage = open(url)
      page = Nokogiri::HTML(webpage)
      page.css("h2").each do |article|
        p article
        title =  article.at_css("a.question_link")
        link = article.at_css("a.question_link")
        complete_link = "http://quora.com/#{board}/#{link}"
        Raw_Data.create(title: "#{title}", link: complete_link, snippet: "", keyword: keyword, source: "quora", post_type: "text", business_id: business_id)
      end
  
      # page = Nokogiri::HTML(open(url))
      # p url
      # page.css("h2").each do |article|
      #   title =  article.at_css("a.question_link").text
      #   link = article.at_css("a.question_link")[:href]
      #   complete_link = "http://quora.com/#{board}/#{link}"
      #   puts title
      #   Raw_Data.create(title: title, link: complete_link, snippet: "", keyword: keyword, source: "quora", post_type: "text", business_id: business_id)
      # end
    
      # url = "http://quora.com/#{board}/best_questions"
      # puts url
      # page = Nokogiri::HTML(open(url))
      # page.css("h2").each do |article|
      #   title =  article.at_css("a.question_link").text
      #   link = article.at_css("a.question_link")[:href]
      #   complete_link = "http://quora.com/#{board}/#{link}"
      #   puts title
      #   Raw_Data.create(title: title, link: complete_link, snippet: "", keyword: keyword, source: "quora", post_type: "text", business_id: business_id)
      # end
    rescue OpenURI::HTTPError
      puts 404
    end
  end
end

