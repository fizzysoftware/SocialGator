module ContentHelper

  def shorten(url)
    Bitly.use_api_version_3
    bitly = Bitly.new("bharani91", "R_6a4731a4c688eef8f7dd4ef8ccaa67d0")
    bitly.shorten(url).short_url
  end
  

  def twitter_text_content(text, link)
  	"#{text} #{shorten(link)}"
  end
  
end
