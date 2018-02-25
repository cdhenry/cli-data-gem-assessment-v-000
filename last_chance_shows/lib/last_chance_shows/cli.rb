#CLI Controller
class LastChanceShows::CLI

  def call
    list_shows
    menu
    goodbye
  end

  def list_shows
    puts "Last Chance to See these Broadway/Off-Broadway Shows in New York City!"
    @shows = LastChanceShows::Shows.closings
    @shows.each.with_index(1) do |show, i|
      puts "#{i}. #{show.title} - #{show.size}: #{show.venue}, #{show.closing}."
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the show you'd like more info on or type 'list' to see the shows again or type 'exit':"
      input = gets.strip.downcase

      if input.to_i > 0
        puts @deals[input.to_i-1]
      elsif input == "list"
        list_shows
      else
        puts "Type in a show number or 'list' or 'exit'"
      end
    end
  end

  def goodbye
     puts "Have a great time, and check back again soon before more shows you want to see close!"
  end
end
