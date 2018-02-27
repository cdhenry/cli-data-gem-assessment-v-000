#Individual show information scraper
class LastChanceShows::Show_Info
  attr_accessor :blurb, :synopsis :schedule, :run_time, :theater_url
  attr_reader :url

  #initialize with a url from a show class object
  def initialize(url)
    @url = url
  end

  def info
    scrape_info
  end
# 
#   def scrape_info
#     doc = Nokogiri::HTML(open(@url))
#     stuff = doc.css(".bsp-bio-text").text.strip
#     if stuff.include?("SYNOPSIS")
#       blurb_i = stuff.index("SYNOPSIS")   
#       self.synopsis = stuff[blurb_i..]
#     if stuff
#       self.blurb = stuff[0..blurb_i-1]
#     self.synopsis = stuff()
#     blurb
#   end
# end
