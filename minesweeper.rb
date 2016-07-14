require_relative "tile"
require_relative "board"

class MineSweeper
  def initialize(board)
    @board = board
  end

  def show_board
    @board.render
  end
end


if $PROGRAM_NAME == __FILE__
  b = Board.new(9,10)
  g = MineSweeper.new(Board.new(9, 10))
  g.show_board
end
