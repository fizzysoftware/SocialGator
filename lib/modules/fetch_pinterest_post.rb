module FetchPinterestPost
    require "open-uri"
    require "nokogiri"
    require 'json'
    require 'net/http'
    require "cgi"
    
    def fetch_pinterest_posts
        keywords = []
        self.keywords.each { |k| keywords << k.token } 
        business_id = self.id
        keywords.each do |keyword|

            url = "http://pinterest.com/search/?q=#{CGI.escape(keyword)}"
            page = Nokogiri::HTML(open(url))
            page.css(".pin").each_with_index do |pin, index|
                pin_url = "http://pinterest.com#{pin.at_css('.PinImage')[:href]}"
                url = "http://api.embed.ly/1/oembed?key=dc41460b16894be582a95c9b89918440&url=#{pin_url}&maxwidth=500"
                resp = Net::HTTP.get_response(URI.parse(url))
                data = resp.body
                result = JSON.parse(data)
                title =  result["title"] || ""
                link = pin_url
                thumbnail_url = result["thumbnail_url"]
                embed_url = result["url"]
                snippet = result["description"]

                Raw_Data.create(title: title, link: link, snippet: snippet, keyword: keyword, thumbnail_url: thumbnail_url, embed_url: embed_url, post_type: "image", source: "pinterest", business_id: business_id)
                break if index > 20
            end

        end
    end

    handle_asynchronously :fetch_pinterest_posts, :priority => 3

end