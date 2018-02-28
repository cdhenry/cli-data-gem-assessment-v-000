#Show scraper for all the shows that are closing soon
class LastChanceShows::Shows

  attr_accessor :title, :venue, :closing, :url

  def self.closings
    self.scrape_closings
  end

  def self.scrape_closings
    #declaration/assignment of variables
    shows = []
    doc = Nokogiri::HTML(open("http://www.playbill.com/article/last-chance-schedule-of-upcoming-broadway-and-off-broadway-show-closings"))
    elements = doc.css(".bsp-article-content").children
    closing_i = 0

    #find relevant Show Class information by iterating through each element in css class '.bsp-article-content'
    elements.each_with_index do |element, i|
      #capture and index for each 'Show Closing' date
      if elements[i].name == "h2"
        closing_i = i
      end
      #find the <p>'s that contain show information based on current site format (2/26/2018)
      if elements[i].name == "p" && closing_i > 0 && !(elements[i].text.include?("To purchase")) && elements[i].children[0].name == "u"
        #for each new show create a show class
        show = self.new
        #assign title based on text in first child of <p>
        show.title = elements[i].children[0].text
        #assign closing based on text in the last <h2> field
        show.closing = elements[closing_i].text
        #assign venue based on second child of <p>, but if it contains links continue to capture venue until a <br>
        venue_i = 2
        venue = ""
        until elements[i].children[venue_i].name == "br"
          venue += elements[i].children[venue_i].text
          venue_i += 1
        end
        show.venue = venue
        #create show url based on current site url system (2/26/2018) ***Must happen after show.title is assigned
        s_url = "http://www.playbill.com/searchpage/search?q="
        title_parse = show.title.split(" ")
        title_parse.each do |word|
          s_url += word + "+"
        end
        s_url.chomp("+")
        s_url = s_url + "&sort=Relevance&shows=on&qasset="
        linkpage = Nokogiri::HTML(open(s_url))
        show.url = "http://www.playbill.com" + linkpage.css(".bsp-list-promo-title a")[0]["href"]
        binding.pry
        #add show to shows array
        shows << show
      end
    end
    #return shows array
    shows
  end
end
