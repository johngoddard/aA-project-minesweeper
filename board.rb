require_relative "tile"
require 'byebug'

class Board

  def initialize(size = 9, bombs = 10)
    @size = size
    @num_bombs = bombs
    @grid = Array.new(size){Array.new(size)}
    randomly_seed
  end


  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def render
    puts "  #{(0...@size).to_a.join(" ")}"

    @grid.each_with_index do |row, row_num|
      print "#{row_num} "
      print row.map{|tile| tile.to_s}.join(" ")
      puts
    end
  end

  private

  def randomly_seed
    bombs = bomb_positions

    (0...@size).each do |row|
      (0...@size).each do |col|
        if bombs.include?([row,col])
          self[[row, col]] = Tile.new(self, true)
        else
          self[[row, col]] = Tile.new(self, false)
        end
      end
    end

  end

  def bomb_positions
    all_positions = []
    (0...@size).each do |row|
      (0...@size).each do |col|
        all_positions << [row,col]
      end
    end

    all_positions.shuffle.take(@num_bombs)
  end


end
