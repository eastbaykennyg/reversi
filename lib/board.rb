require 'debugger'
require 'colorize'

class Board
  attr_accessor :rows, :piece
  VECTORS = [
    [-1, 0],
    [-1, 1],
    [ 0, 1],
    [ 1, 1],
    [ 1, 0],
    [ 1,-1],
    [ 0,-1],
    [-1,-1]
  ]

  def initialize
    @rows = Array.new(8) { Array.new(8) }
    first_pieces
  end

  def inspect
    nil
  end

  def first_pieces
    rows[3][3] = Piece.new( :red, [3,3])
    rows[3][4] = Piece.new( :blue, [3,4])
    rows[4][4] = Piece.new( :red, [4,4])
    rows[4][3] = Piece.new( :blue, [4,3])
  end

  def place_piece(color, position)
    x, y = position
    @rows[x][y] = Piece.new(color, position )
  end

  def render
    system("clear")
    @rows.each do |row|
      row_string = ""
      row.each do |spot|
        if spot.nil?
          row_string += "|__|".colorize(:background => :yellow)
        elsif spot.color == :blue
          row_string += " 0  ".colorize(:background => :yellow, :color => :blue)
        else
          row_string += " 0  ".colorize(:background => :yellow, :color => :red)
        end
      end
      puts row_string
    end
  end

  def in_bounds?(position)
    position.all? { |coord| (0...8).include?(coord) }
  end

  def empty?(position)
    row, col = position
    @rows[row][col] == nil
  end

  def pieces_to_flip(position, color)
    raise "out of bounds" unless in_bounds?(position)
    raise "already contains a piece" unless empty?(position)
    p_row, p_col = position
    flips = []
    #debugger
    VECTORS.each do |row, col|
      test_pos = [p_row + row, p_col + col]
      x, y = test_pos
      possible_flip = []

      next unless in_bounds?(test_pos)
      next if empty?(test_pos)
      next if @rows[x][y].color == color
      until @rows[x][y].color == color
        possible_flip << test_pos
        t_row, t_col = test_pos
        x = t_row + row
        y = t_col + col
        test_pos = [x, y]
        if empty?(test_pos) or !in_bounds?(test_pos)
          possible_flip = []
          break
        end
      end
      flips += possible_flip unless possible_flip.count == 0

    end

    if flips.count > 0
      flips
    else
      false
    end

  end


end