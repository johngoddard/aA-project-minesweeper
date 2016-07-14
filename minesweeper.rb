require_relative "tile"
require_relative "board"
require "yaml"

class MineSweeper
  def initialize(board)
    @board = board
  end

  def play
    @playing = true

    until (won? || lost?) || !@playing
      system("clear")
      show_board
      pos = get_pos
      val = get_val

      make_move(pos, val) if @playing
    end
  end

  def show_board
    @board.render
  end

  private

  def won?
    if @board.won?
      puts "player wins!"
      system("clear")
      @board.render_end(true)
    end
    @board.won?
  end

  def lost?
    if @board.lost?
      system("clear")
      @board.render_end(false)
      puts "Player loses!"
    end
    @board.lost?
  end

  def get_pos
    pos = nil

    until (pos && valid_pos?(pos)) || !@playing
      puts "Please enter a position (e.g. 1,3)"
      print ">"

      pos = parse_pos(STDIN.gets.chomp)
    end

    pos
  end

  def save_game
    saved_board = @board.to_yaml
      File.open("saved_game_#{Time.now.strftime("%H:%M")}.yml", 'w') do |f|
        f.write saved_board
      end
    @playing = false
    puts "Game is saved"
  end

  def parse_pos(string)
    if string == "save"
      save_game
    else
      raw_pos = string.split(",").map(&:to_i)
      raw_pos.map{|n| n - 1}
    end
  end

  def valid_pos?(pos)
    valid = (
      pos.is_a?(Array) &&
      pos.size == 2 &&
      pos.all?{|el| el.is_a?(Integer) && el.between?(0, @board.size - 1)} &&
      @board.tile_status(pos) != :revealed
      )
    puts "Invalid position! Try again!" unless valid
    valid
  end

  def get_val
    val = nil

    until val && valid_val?(val) || !@playing
      puts "Would you like to reveal (r), flag (f), or unflag (u) the position?"
      print ">"

      val = STDIN.gets.chomp
    end

    val
  end



  def valid_val?(val)
    valid = val.size == 1 && ["r", "f", "u"].include?(val)
    puts "Invalid move! Try again!" unless valid
    valid
  end

  def make_move(pos, val)
    @board.update_tile(pos, val)
  end

end


if $PROGRAM_NAME == __FILE__
  unless ARGV[0].nil?
    g = MineSweeper.new(YAML.load_file(ARGV[0].chomp))
  else
    g = MineSweeper.new(Board.new())
  end
  g.play
end
