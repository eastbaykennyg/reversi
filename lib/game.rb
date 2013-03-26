require './board.rb'
require './piece.rb'

class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [:red, :blue]
  end

  def input(player)
    puts "#{player} turn"
    puts "Pick a row (0 to 7):"
    row_input = Integer(gets.chomp)
    puts "Pick a column (0 to 7):"
    col_input = Integer(gets.chomp)
    [[row_input, col_input], player]
  end

  def play
    player = @players[0]
    until end?
     @board.render
     move, color = input(player)
     if @board.valid_move?(move, color)
       to_flip = @board.pieces_to_flip(move, color)
       @board.place_piece(move, color)
       to_flip.each do |x, y|
         @board.rows[x][y].change_color
       end
     end
     player = (player == @players[0]) ? @players[1] : @players[0]

    end
  end

  def end?
    @board.rows.each do |row|
      row.each do |spot|
        if spot.nil?
          if @board.valid_move?([row,spot], :red)||
            @board.valid_move?([row,spot], :red)
            return true
          end
        end
      end
    end

    false
  end


end

