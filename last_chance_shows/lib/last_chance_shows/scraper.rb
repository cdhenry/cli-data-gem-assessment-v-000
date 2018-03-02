class LastChanceShows::Scraper

  def self.get_page
    Nokogiri::HTML(open("http://www.playbill.com/article/last-chance-schedule-of-upcoming-broadway-and-off-broadway-show-closings"))
  end

  def self.get_shows
    self.get_page.css(".bsp-article-content").children #all the elements in the .bsp-article-content class
  end

  def self.make_shows
    closing_i = 0   #index counter for keeping track of the 'Closing..' <h2>'s

    self.get_shows.each_with_index do |element, i| #find shows and closings by iterating through each child of '.bsp-article-content'
      if element.name == "h2" #capture and index for each 'Show Closing' date
        closing_i = i
      end

      if element.name == "p" && closing_i > 0 && !(element.text.include?("To purchase")) && element.children[0].name == "u" #find the <p>'s that contain show information based on current site format (2/26/2018)
        title = element.children[0].text #assign title based on text in first child of <p>
        closing = elements[closing_i].text #assign closing based on text in the last <h2> field
      end

      url = get_show_url

      LastChanceShows::Show.new(title, closing, url)
    end
  end

  def get_search_url
    #create show url based on current site url system (2/26/2018) ***Must happen after show.title is assigned
    search_url = "http://www.playbill.com/searchpage/search?q="
    title_parse = show.title.split(" ")

    title_parse.each do |word|
      if word.length > 2
        search_url += word + "+"
      end
    end
    search_url.chomp("+")
    search_url = show_url + "&sort=Relevance&shows=on&qasset="
  end

  def get_show_url
    linkpage = Nokogiri::HTML(open(search_url))
    show_links = linkpage.css(".bsp-list-promo-title a")

    show_links.each do |item|
      #this is a temporary if statement for a show currently on the website that has a formatting error
      #this should be removed in subsequent updates and a better fix for formatting errors should be concieved
      if item.text.match(/[\u007B-\u00BF\u02B0-\u037F\u2000-\u2BFF]/)
        if item.text.strip.length - 11 == show.title.length && item.text.strip[-5..-2].to_i >= Time.now.year - 30
          show.url = "http://www.playbill.com" + item["href"]
        end
      end

      #check to see if the searched for link matches the shows title
      if item.text.strip.length - 7 == show.title.length && item.text.strip[-5..-2].to_i >= Time.now.year - 30
        show.url = "http://www.playbill.com" + item["href"]
      end
    end
  end

  #
  #   closing_i = 0 #index counter for keeping track of the 'Closing..' <h2>'s
  #   #find relevant Show Class information by iterating through each element in css class '.bsp-article-content'
  #   elements.each_with_index do |element, i|
  #     if element.name == "h2"   #capture and index for each 'Show Closing' date
  #       closing_i = i
  #     end
  #     #find the <p>'s that contain show information based on current site format (2/26/2018)
  #     if element.name == "p" && closing_i > 0 && !(element.text.include?("To purchase")) && element.children[0].name == "u"
  #
  #
  #   binding.pry
  # end

end
