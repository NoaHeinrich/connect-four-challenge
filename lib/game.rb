require_relative 'board'

# This class is for initializing and running a game. It will
# need a new board and a way to keep track of who is the
# current player. The rest is up to you:
class Game
  def initialize
    @board = Board.new
    @current_player = :black
    @board.print_grid
  end

  def start
    puts 'A new game has begun!'
    until @board.game_won?
      @board.print_grid
      puts "#{@current_player} it is your turn:"
      column = gets.chomp.to_i
      unless @board.column_full?(column)
        @board.drop_checker(@current_player, column)
        @current_player == :black ? @current_player = :red : @current_player = :black
      end
    end
    @board.print_grid
    puts "Winner!"
  end

end
