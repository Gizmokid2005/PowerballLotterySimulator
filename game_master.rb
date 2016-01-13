require_relative 'powerball_generator'
require_relative 'arg_parser'
require_relative 'balls_result'
require_relative 'prizes'
class GameMaster
  def initialize args
    @powerball_generator = PowerballGenerator.new
    @lottery_prizes = LotteryPrizes.new
    arg_parser = ArgParser.new args
    options = arg_parser.parse(args)
    puts options.inspect
    @number_of_games = options[:number_of_games]
    @number_white_balls_match = options[:number_white_balls_match]
    @match_red_ball = options[:match_red_ball]
    @grand_prize = options[:grand_prize]
    @ticket_price = options[:ticket_price]
    # Win Tracking
    @winnings = 0
    @red_wins = 0
    @one_plus_red_wins = 0
    @two_plus_red_wins = 0
    @three_wins = 0
    @three_plus_red_wins = 0
    @four_wins = 0
    @four_plus_red_wins = 0
    @five_wins = 0
    @five_plus_red_wins = 0
  end

  def run
    wins = 0
    spent = 0
    (1..@number_of_games).each do |game|
      wins += 1 if win_a_game?
      spent += @ticket_price
    end
    puts "Won #{fancy_numbers(wins)} times out of #{fancy_numbers(@number_of_games)}"
    winning_percent = wins / @number_of_games.to_f * 100
    puts "5 + Powerball Matches: #{fancy_numbers(@five_plus_red_wins)}"
    puts "5 Matches: #{fancy_numbers(@five_wins)}"
    puts "4 + Powerball Matches: #{fancy_numbers(@four_plus_red_wins)}"
    puts "4 Matches: #{fancy_numbers(@four_wins)}"
    puts "3 + Powerball Matches: #{fancy_numbers(@three_plus_red_wins)}"
    puts "3 Matches: #{fancy_numbers(@three_wins)}"
    puts "2 + Powerball Matches: #{fancy_numbers(@two_plus_red_wins)}"
    puts "1 + Powerball Matches: #{fancy_numbers(@one_plus_red_wins)}"
    puts "Powerball Matches: #{fancy_numbers(@red_wins)}"
    puts "Winning percent: #{winning_percent.round(2)}%"
    puts "Money Spent: $#{fancy_numbers(spent)}"
    puts "Winnings: $#{fancy_numbers(@winnings)}"
    puts "Loss: $#{fancy_numbers(@winnings-spent)}"
  end

  def win_a_game?
    player_balls_result, actual_balls_result = play_a_game
    return match(player_balls_result, actual_balls_result)
  end

  def play_a_game
    player_balls_result = @powerball_generator.generate
    actual_balls_result = @powerball_generator.generate
    return player_balls_result, actual_balls_result
  end

  def match(player_balls_result, actual_balls_result)
    intersection = player_balls_result.white_balls & actual_balls_result.white_balls
    red_ball_match = true unless player_balls_result.powerball != actual_balls_result.powerball
    if red_ball_match
      #We matched the red ball
      if intersection.length == 0
        @winnings += @lottery_prizes.prize_red
        @red_wins += 1
        return true
      elsif intersection.length == 1
        @winnings += @lottery_prizes.prize_one_plus_red
        @one_plus_red_wins += 1
        return true
      elsif intersection.length == 2
        @winnings += @lottery_prizes.prize_two_plus_red
        @two_plus_red_wins += 1
        return true
      elsif intersection.length == 3
        @winnings += @lottery_prizes.prize_three_plus_red
        @three_plus_red_wins += 1
        return true
      elsif intersection.length == 4
        @winnings += @lottery_prizes.prize_four_plus_red
        @four_plus_red_wins += 1
        return true
      elsif intersection.length == 5
        @winnings += @grand_prize
        @five_plus_red_wins += 1
        return true
      end
    else
      #We didn't match the red ball
      if intersection.length == 3
        @winnings += @lottery_prizes.prize_three
        @three_wins += 1
        return true
      elsif intersection.length == 4
        @winnings += @lottery_prizes.prize_four
        @four_wins += 1
        return true
      elsif intersection.length == 5
        @winnings += @lottery_prizes.prize_five
        @five_wins += 1
        return true
      else
        return false
      end
      return false
    end
  end

  def fancy_numbers(amount)
    amount.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

end

game_master = GameMaster.new ARGV
game_master.run 
