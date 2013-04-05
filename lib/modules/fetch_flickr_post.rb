module FetchFlickrPost
    require "fleakr"
    require 'json'
    require 'net/http'
    Fleakr.api_key = 'e437010247bb99bb4d31eab39b4e8acb'
    
    def fetch_flickr_posts
        keywords = []
        self.keywords.each { |k| keywords << k.token } 
        business_id = self.id
        keywords.each do |keyword|

            photos = Fleakr.search(keyword)
            photos.each_with_index do |photo, index|
                url = "http://api.embed.ly/1/oembed?key=dc41460b16894be582a95c9b89918440&url=#{photo.url}&width=300&chars=100"
                resp = Net::HTTP.get_response(URI.parse(url))
                data = resp.body
                result = JSON.parse(data)
                title =  result["title"] || ""
                link = photo.url
                thumbnail_url = result["thumbnail_url"]
                embed_url = result["url"]
                #snippet = shorten(result["description"])
                break if index > 20
    
                Raw_Data.create(title: title, link: link, snippet: "", keyword: keyword, thumbnail_url: thumbnail_url, embed_url: embed_url, post_type: "image", source: "flickr", business_id: business_id)
                break if index > 20
            end

        end
    end

    handle_asynchronously :fetch_flickr_posts, :priority => 3

end