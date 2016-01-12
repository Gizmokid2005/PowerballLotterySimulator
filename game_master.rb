require_relative 'powerball_generator'
require_relative 'arg_parser'
require_relative 'balls_result'
class GameMaster
  def initialize args
    @powerball_generator = PowerballGenerator.new
    arg_parser = ArgParser.new args
    options = arg_parser.parse(args)
    puts options.inspect
    @number_of_games = options[:number_of_games]
    @number_white_balls_match = options[:number_white_balls_match]
    @match_red_ball = options[:match_red_ball]
  end

  def run
    wins = 0
    (1..@number_of_games).each do |game|
      wins += 1 if win_a_game?
    end 
    puts "Won #{wins} times out of #{@number_of_games}"
    winning_percent = wins / @number_of_games.to_f * 100 
    puts "Winning percent: #{winning_percent.round(2)}%"
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

  def match player_balls_result, actual_balls_result 
    intersection = player_balls_result.white_balls & actual_balls_result.white_balls
    if intersection.length == @number_white_balls_match
      if @match_red_ball && player_balls_result.powerball != actual_balls_result.powerball
        return false
      end
      return true
    end
    return false
  end
end

game_master = GameMaster.new ARGV
game_master.run 
