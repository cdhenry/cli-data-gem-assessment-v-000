#Individual show information scraper
class LastChanceShows::Show
  attr_accessor :blurb, :schedule, :run_time, :theater_url
  attr_reader :url

  def self.info(url)
    self.scrape_info(url)
  end

  def self.scrape_info(url)
    doc = Nokogiri::HTML(open(url))
    info = doc.css(".bsp-bio-text").text.strip
    last = info.length
    show = self.new

    #search for where 'schedule' or 'show times' are printed and format text accordingly
    if info.include?("SCHEDULE")
      blurb_i = info.index /[.]\S/
      schedule_i = info.index("SCHEDULE")
      show.blurb = info[0..blurb_i]
      show.schedule = info[schedule_i..last]
    elsif info.include?("Show Times")
      blurb_i = info.index /[.]\S/
      schedule_i = info.index("Show Times")
      last_i = info.index("Tickets") - 1
      show.blurb = info[0..blurb_i]
      show.schedule = info[schedule_i..last_i]
    end
    #find where run time is listed
    list = doc.css(".bsp-bio-primary-list")
    show.run_time = list.children[1].text.strip

    #get the theater url from a level deeper
    show.theater_url = self.get_theater_url(url)

    show
  end

  def self.get_theater_url(url)
    doc = Nokogiri::HTML(open(url))
    internal_url = "http://www.playbill.com" + doc.css(".bsp-bio-links a")[0]["href"]
    #use the internal_url page to find the url for the theater's external site
    doc2 = Nokogiri::HTML(open(internal_url))
    doc2.css(".bsp-bio-sub-text a")[1]["href"]
  end

end
