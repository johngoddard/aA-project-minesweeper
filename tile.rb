class Tile
  attr_accessor :status

  OUTPUT_STRINGS = {
    hidden: "X",
    explored: "_",
    flagged: "F"
  }

  def initialize(board, bomb)
    @board = board
    @status = :hidden
    @fringe_value = nil
    @bomb = bomb
  end

  def to_s
    @fringe_value.nil? ? OUTPUT_STRINGS[status] : @fringe_value.to_s
  end

  def reveal(fringe = false, fringe_val = nil)
    @status = :explored
    @fringe_val = fringe_val if fringe
  end

  def flag
    @status = :flagged
  end

  def bomb?
    false
  end

  def inspect
    { 'status' => @status, 'fringe_value' => @fringe_value, 'bomb' => @bomb }.inspect
  end

  private
  attr_reader :board
end
