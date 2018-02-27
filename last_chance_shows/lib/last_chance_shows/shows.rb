class LastChanceShows::Shows

  attr_accessor :title, :venue, :closing, :url

  def self.closings
    # puts <<-DOC.gsub /^\s*/, ""
    #   "Closing Sunday, February 25, 2018"
    #   "1. LATIN HISTORY FOR MORONS - Broadway: Studio 54"
    #   "2. CARDINAL - Off-Broadway: Second Stage Theater/Tony Kiser Theatre"
    #   "3. MILES FOR MARY - Off-Broadway: Playwrights Horizons/Peter Jay Sharp Theater"
    #   "Closing Friday, March 2, 2018"
    #   "4. FIRE AND AIR - Off-Broadway: Classic Stage Company"
    # DOC

    # #show_count
    # doc = Nokogiri::HTML(open("http://www.playbill.com/article/last-chance-schedule-of-upcoming-broadway-and-off-broadway-show-closings"))
    # show_count = doc.css("u").length
    #
    # #close_count
    # doc2 = Nokogiri::HTML(open("http://www.playbill.com/article/last-chance-schedule-of-upcoming-broadway-and-off-broadway-show-closings"))
    # close_count = doc2.css(".cms-h2-h2").length
    # binding.pry

    #self.scrape_shows
  end

  # def self.how_many_shows?
  #   doc = Nokogiri::HTML(open("http://www.playbill.com/article/last-chance-schedule-of-upcoming-broadway-and-off-broadway-show-closings"))
  #   doc.css("u").length
  # end

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
      if elements[i].name == "p" && closing_i > 0 && !(elements[i].text.include?("To purchase"))
        #for each new show create a show class
        binding.pry
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
        s_url.chomp"+"
        s_url = s_url + "&qasset="
        show.url = s_url
      end
      shows << show
    end

    # shows = []
    # show_counter = (self.how_many_shows? - 1)
    # while show_counter >= 0
    #   show_index = (self.how_many_shows? - 1) - show_counter
    #   doc.css(".bsp-article-content h2").each do |element|
    #     shows << self.scrape_shows(element, show_index)
    #   end
    # end

    #
    # shows = []
    #
    # while show_counter > -1
    #   show_index = self.how_many_shows? - show_counter - 1
    #   shows << self.scrape_playbill(show_index)
    #   show_counter -= 1
    # end
    # show_1 = self.new
    # show_1.title = "LATIN HISTORY FOR MORONS"
    # show_1.size = "Broadway"
    # show_1.venue = "Studio 54"
    # show_1.closing = "Sunday, February 25, 2018"
    # show_1.url = "http://www.playbill.com/production/latin-history-for-morons-studio-54-2017-2018"
    #
    # show_2 = self.new
    # show_2.title = "CARDINAL"
    # show_2.size = "Off-Broadway"
    # show_2.venue = "Second Stage Theater/Tony Kiser Theatre"
    # show_2.closing = "Sunday, February 25, 2018"
    # show_2.url = "http://www.playbill.com/production/cardinal-tony-kiser-theatre-2017-2018"

    shows
  end
  #
  # def self.get_venue(venue_index)
  #   venue_p = element.parent.css("p")[venue_index].text
  #   venue_p = doc.css(".bsp-article-content p")[venue_index].text
  #   first = venue_p.index(": ") + 2
  #   last = venue_p.index("\n") - 1
  #   venue_p[first..last]
  # end
  #
  # def self.scrape_playbill#(show_number)
  #   show = self.new
  #   doc = Nokogiri::HTML(open("http://www.playbill.com/article/last-chance-schedule-of-upcoming-broadway-and-off-broadway-show-closings"))
  #
  #   doc.css(".bsp-article-content h2").each do |element|
  #     show.closing = element.text
  #     show.title = element.parent.css()
  #     element.parent.css("u")[show_index].text
  #
  #     # if element == "p"
  #     #   if element == "u"
  #     #     element
  #         binding.pry
  #       # end
  #     #
  #   end
  # end



    # show = self.new
    # size_element = 2 * (show_number + 1)
    # str1_markerstring = ": "
    # str2_markerstring = "\n"
    # doc = Nokogiri::HTML(open("http://www.playbill.com/article/last-chance-schedule-of-upcoming-broadway-and-off-broadway-show-closings"))
    # doc.search('br').each { |br| br.replace("\n") }
    #
    # show.title = doc.css("u")[show_number].text
    #
    # if doc.css(".bsp-article-content p")[size_element].text.include?"Off-Broadway:"
    #   show.size = "Off-Broadway"
    # else
    #   show.size = "Broadway"
    # end
    #
    # venue_p = doc.css(".bsp-article-content p")[size_element].text
    # first = venue_p.index(": ") + 2
    # last = venue_p.index("\n") - 1
    # show.venue = venue_p[first..last]
    # #change show closing time to scrape previous h2
    # nodes = doc.css(".bsp-article-content p")
    # nodes.wrap("<div class='container'></div>")
    # show.closing = doc.css("u")[show_number].text
    #
    # s_address = "http://www.playbill.com/searchpage/search?q="
    # parse_title = show.title.split(" ")
    # parse_title.each do |word|
    #   s_address += word + "+"
    # end
    # s_address.chomp"+"
    # s_address = s_address + "&qasset="
    #
    # doc2 = Nokogiri::HTML(open(s_address))
    # show.url = "http://www.playbill.com" + doc2.css(".bsp-list-promo-title a")[0]["href"]
  #end
end
