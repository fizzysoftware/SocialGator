module FetchTopsy
    require "nokogiri"
    require "open-uri"
    require "cgi"
    require "json"
    require "net/http"
    
    def fetch_topsy_posts
        keywords = []
        self.keywords.each { |k| keywords << k.token }
        business_id = self.id
        keywords.each do |keyword|
            url = "http://otter.topsy.com/search.json?q=#{CGI.escape(keyword)}&window=dynamic&perpage=30"
            resp = Net::HTTP.get_response(URI.parse(url))
            data = resp.body
            result = JSON.parse(data)
            result["response"]["list"].each do |item|
                title = item["title"]
                link = item["url"]
                Raw_Data.create(title: title, link: link, snippet: "", keyword: keyword, post_type: "text", source: "topsy", business_id: business_id)
            end
        end
    end

    handle_asynchronously :fetch_topsy_posts, :priority => 3

end