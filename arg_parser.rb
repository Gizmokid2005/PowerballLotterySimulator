require "optionparser"

class ArgParser
  def initialize args
    @options = {:match_red_ball => false}
    initialize_parser
  end

  def parse args
    begin
      parse_user_input args
    rescue ArgumentError => e
      display_error_message e
      exit(1)
    end
    return @options
  end

  def initialize_parser
    @optparse  = OptionParser.new do |o|
      o.banner = "Usage: Simulate Powerball Lottery"
      o.separator  ""
      o.separator  "Options"
      o.on(     '-B', "--white_balls_match  number_of_white_balls_match", Integer, "Provide number of white balls match to consider a win. If not provided we will check all possibilities.") { |balls| @options[:number_white_balls_match] = balls }
      o.on(     '-G', "--grand_prize  sum_of_grand_prize", Integer, "Provide the grand prize amount") { |gprize| @options[:grand_prize] = gprize }
      o.on(     '-N', "--simulated_games  number_of_simulated_games", Integer, "Provide number of games you want simulated.") { |number| @options[:number_of_games] =  number }
      o.on(     '-P', "--ticket_price  price_of_each_ticket", Integer, "Provide the ticket price") { |price| @options[:ticket_price] = price }
      o.on(     '-R', "--red_ball_match", "Flag for whether red ball should be matched to consider a win.") { @options[:match_red_ball] = true }
      o.on_tail('-H', "--help"               , "Show this message") { puts o; exit }
    end
  end

  def parse_user_input args
    @optparse.parse!(args)
    if !all_required_values_entered?
      raise ArgumentError, get_error_message_for_missing_required_argument
    end
  end

  def all_required_values_entered?
    return !@options[:number_of_games].nil? #&& !@options[:number_white_balls_match].nil?
  end

  def get_error_message_for_missing_required_argument
    error_message = ""
    if @options[:number_of_games].nil?
      error_message += "Missing field value for number_of_games. "
    end
    # if @options[:number_white_balls_match].nil?
    #   error_message += "Missing field value for number_white_balls_match. "
    # end

    return error_message
  end

  def display_error_message error_message
    puts error_message
    puts @optparse
  end

end
