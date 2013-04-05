module FetchYoutubePost
    require "open-uri"
    require "youtube_search"
    require 'json'
    require 'net/http'
    require "cgi"
    #require 'youtube_it'
    
    def fetch_youtube_posts
        keywords = []
        self.keywords.each { |k| keywords << k.token } 
        business_id = self.id
        keywords.each do |keyword|
            urls = []
            #client = YouTubeIt::Client.new
            #client.videos_by(:categories => [:news, :sports]).each do |video|
            YoutubeSearch.search("#{CGI.escape(keyword)}", :per_page => 20).each do |video|
                url =  "http://youtube.com/watch?v=#{video['video_id']}"
                urls << url
            end
            escaped_urls = urls.collect {|u| "#{CGI.escape(u)}"}.join(",")  
            url = "http://api.embed.ly/1/oembed?key=dc41460b16894be582a95c9b89918440&urls=#{escaped_urls}"
            resp = Net::HTTP.get_response(URI.parse(url))
            data = resp.body
            result = JSON.parse(data)
            result.each do |res|
                link = res["url"]
                title =  res["title"]
                thumbnail_url = res["thumbnail_url"]
                embed_url = res["html"]
                snippet = res["description"]
    
                Raw_Data.create(title: title, link: link, snippet: snippet, keyword: keyword, thumbnail_url: thumbnail_url, embed_url: embed_url, post_type: "video", source: "youtube", business_id: business_id)
            end
        end
    end

    handle_asynchronously :fetch_youtube_posts, :priority => 3

end