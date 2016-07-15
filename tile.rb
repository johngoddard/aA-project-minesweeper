require 'colorize'

class Tile
  attr_accessor :status, :fringe_value

  OUTPUT_STRINGS = {
    hidden: "X",
    revealed: "_",
    flagged: "F"
  }

  FRINGE_COLORS = [:blue, :green, :yellow, :orange, :purple, :purple, :purple, :purple]


  def initialize(bomb)
    @status = :hidden
    @fringe_value = nil
    @bomb = bomb
  end

  def to_s
    @fringe_value.nil? ? OUTPUT_STRINGS[status].colorize(OUTPUT_COLORS[status]) :
    @fringe_value.to_s.colorize(FRINGE_COLORS[@fringe_value - 1])
  end

  def reveal(fringe = false, fringe_val = nil)
    @status = :revealed
    @fringe_val = fringe_val if fringe
  end

  def flag
    @status = :flagged
  end

  def bomb?
    @bomb
  end

  def inspect
    { 'status' => @status, 'fringe_value' => @fringe_value, 'bomb' => @bomb }.inspect
  end

  private
  attr_reader :board
end
