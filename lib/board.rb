# Use this as a sketch of how your Board class could look, you can fill in these
# methods, or make a different class from scratch
require 'tty-table'
require 'colored2'
class Board
  attr_reader :table
  attr_accessor :rows

  def initialize
    generate_board
    @last_move = []
  end

  # [
  #   ["","","","","","",""],
  #   ["","","","","","",""],
  #   ["","","","","","",""],
  #   ["","","","","","",""],
  #   ["","","","","","",""],
  #   ["","","","","","",""]
  # ]

  def drop_checker(color, column)
    row = 5
    while row >= 0
      if @rows[row][column] == ""
        @rows[row][column] = "O".send(color)
        @last_move = [row, column]
        return true
      end
      row -= 1
    end
    false
  end

  def column_full?(column)
    @rows[0][column] != ""
  end

  def generate_board
    rows = []
    6.times do
      rows << []
    end

    rows.each do |r|
      7.times do
        r << empty_string
      end
    end
    @rows = rows
  end

  def empty_string
    "".freeze
  end

  def headers
    [0, 1, 2, 3, 4, 5, 6]
  end

  def print_grid
    @table = TTY::Table.new headers, @rows
    puts @table.render(:ascii, padding: [1, 2, 1, 2])
  end

  def check_horizontal
    @rows.each do |row|
      row.each_with_index do |cell, index|
        if cell != "" && index <= 3
          if cell == row[index+1] && cell == row[index+2] && cell == row[index+3]
            return true
          end
        end
      end
    end
    false
  end

  def check_vertical
    (0..6).each do |column|
      (0..2).each do |row|
        if @rows[row][column] != ""
          if @rows[row][column] == @rows[row+1][column] && @rows[row][column] == @rows[row+2][column] && @rows[row][column] == @rows[row+3][column]
            return true
          end
        end
      end
    end
    false
  end

  def check_diagonal
    win = false
    (0..2).each do |row|
      @rows[row].each_with_index do |cell, column|
        if column < 3
          win = check_right_down(row, column)
        elsif column > 3
          win = check_left_down(row, column)
        else
          check_right_down(row, column) ? win = true : win = check_left_down(row, column)
        end
        if win
          return true
        end
      end
    end
    false
  end

  def check_right_down(row, column)
    if @rows[row][column] != "" && @rows[row][column] == @rows[row+1][column+1] && @rows[row][column] == @rows[row+2][column+2] && @rows[row][column] == @rows[row+3][column+3]

      true
    else
      false
    end
  end

  def check_left_down(row, column)
    if @rows[row][column] != "" && @rows[row][column] == @rows[row+1][column-1] && @rows[row][column] == @rows[row+2][column-2] && @rows[row][column] == @rows[row+3][column-3]
      true
    else
      false
    end
  end

  def game_won?
    if check_horizontal || check_vertical || check_diagonal
      true
    else
      false
    end
  end
end
