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
end
