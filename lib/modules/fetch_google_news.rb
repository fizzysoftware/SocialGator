module FetchGoogleNews
    require "nokogiri"
    require "open-uri"
    require "cgi"
    
    def fetch_google_news_posts
        keywords = []
        self.keywords.each { |k| keywords << k.token }
        business_id = self.id
        keywords.each do |keyword|
          url = "http://news.google.com/?q=#{CGI.escape(keyword)}&ned=us"
          page = Nokogiri::HTML(open(url))
          page.css(".esc-body").each do |article|
            title =  article.at_css(".esc-lead-article-title").text
              link = article.at_css(".esc-lead-article-title > a")[:href]
              snippet = article.at_css(".esc-lead-snippet-wrapper").text
              Raw_Data.create(title: title, link: link, snippet: snippet, keyword: keyword, post_type: "text", source: "google_news", business_id: business_id)
          end
        end
    end

    handle_asynchronously :fetch_google_news_posts, :priority => 3

end