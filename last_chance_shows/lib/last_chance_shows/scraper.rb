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

      show.new(title, closing)
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
