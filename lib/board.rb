# Use this as a sketch of how your Board class could look, you can fill in these
# methods, or make a different class from scratch
require 'tty-table'

class Board
  attr_reader :table
  attr_accessor :rows

  def initialize
    generate_board
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
        @rows[row][column] = color
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

  end

  def game_won?
    if check_horizontal || check_vertical
      true
    else
      false
    end
  end
end
