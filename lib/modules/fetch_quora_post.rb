module FetchQuoraPost
    require "nokogiri"
    require "open-uri"
    require "cgi"
    require 'net/http'
    
    def fetch_quora_posts
      keywords = []
        self.keywords.each { |k| keywords << k.token }
        business_id = self.id
        keywords.each do |keyword|
            board = keyword
        url = "http://quora.com/#{CGI.escape(board)}/"
        begin
            webpage = open(url)
            page = Nokogiri::HTML(webpage)
            page.css("h2").each do |article|
                title =  article.at_css("a.question_link")
                link = article.at_css("a.question_link")
                complete_link = "http://quora.com/#{board}/#{link}"
                Raw_Data.create(title: "#{title}", link: complete_link, snippet: "", keyword: keyword, source: "quora", post_type: "text", business_id: business_id)
            end
  
        rescue OpenURI::HTTPError
            puts 404
        end
    end
    end

    handle_asynchronously :fetch_quora_posts, :priority => 3

end