#CLI Controller
class LastChanceShows::CLI

  def call
    puts "Last Chance to See these Broadway/Off Broadway Shows in New York City!"
    list_shows
    menu
    goodbye
  end

  def list_shows
    puts <<-DOC.gsub /^\s*/, ""
      "Closing Sunday, February 25, 2018"
      "1. LATIN HISTORY FOR MORONS - Broadway: Studio 54"
      "2. CARDINAL - Off-Broadway: Second Stage Theater/Tony Kiser Theatre"
      "3. MILES FOR MARY - Off-Broadway: Playwrights Horizons/Peter Jay Sharp Theater"
      "Closing Friday, March 2, 2018"
      "4. FIRE AND AIR - Off-Broadway: Classic Stage Company"
    DOC
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the show you'd like more info on or type 'list' to see the shows again or type 'exit':"
      input = gets.strip.downcase
      case input
      when  "1"
        puts "More info on show 1..."
      when "2"
        puts "More info on show 2..."
      when "list"
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
