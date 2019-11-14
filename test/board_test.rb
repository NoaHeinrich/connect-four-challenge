require 'test_helper'

class BoardTest < MiniTest::Test
  def setup
    @board = Board.new
  end
  def test_the_truth
    assert_equal true, true
  end

  def test_board_size
    assert_equal 6, @board.rows.length
  end

  def test_horizontal_win
    @board.generate_board
    (0..3).each do |n|
      @board.rows[0][n] = :black
    end
    assert_equal true, @board.check_horizontal
  end

  def test_check_right_down
    @board.generate_board
    @board.rows[0][0] = :black
    @board.rows[1][1] = :black
    @board.rows[2][2] = :black
    @board.rows[3][3] = :black
    assert_equal true, @board.check_right_down(0, 0)
  end

  def test_check_left_down
    @board.generate_board
    @board.rows[0][6] = :black
    @board.rows[1][5] = :black
    @board.rows[2][4] = :black
    @board.rows[3][3] = :black
    assert_equal true, @board.check_left_down(0, 6)
  end

  def test_check_diagonal
    @board.generate_board
    @board.rows[2][3] = :black
    @board.rows[3][2] = :black
    @board.rows[4][1] = :black
    @board.rows[5][0] = :black
    assert_equal true, @board.check_diagonal
  end

  def test_drop_checker
    @board.generate_board

    assert_equal true, @board.drop_checker(:red, 0)
    assert_equal "O", @board.rows[5][0]
  end
end
