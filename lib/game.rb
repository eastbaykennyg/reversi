require './board.rb'
require './piece.rb'

class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [:red, :blue]
    @ai_player = [:red]
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
    until end?(player)
     @board.render
     received_move = false

     until received_move || end?(player)
       move, color = input(player)
       received_move = @board.valid_move?(move, color)
     end
     to_flip = @board.pieces_to_flip(move, color)
     @board.place_piece(move, color)
     to_flip.each do |x, y|
       @board.rows[x][y].change_color
     end

     player = (player == @players[0]) ? @ai_player : @players[0]

    end
  end

  def end?(color)
    @board.rows.each do |row|
      row.each do |spot|
        if spot.nil?
          if @board.valid_move?([row,spot], color)
            return true
          end
        end
      end
    end

    false
  end
  def ai_play
    player = @players[1]
    until end?(player)
     @board.render
     received_move = false

     until received_move || end?(player)
       move, color = input(player)
       received_move = @board.valid_move?(move, color)
     end
     to_flip = @board.pieces_to_flip(move, color)
     @board.place_piece(move, color)
     to_flip.each do |x, y|
       @board.rows[x][y].change_color
     end

     player = (player == @players[0]) ? @players[1] : @players[0]

    end

  end
  def ai_player #input but for AI
    best_play  = [nil, 0]
    @board.rows.each do |row|
      row.each do |spot|
        if spot.nil?
          if @board.valid_move?([row,spot], :red)

            count = @board.piece_to_flip([row,spot], :red).count
            if count > best_play[1]
              best_play = [[row, spot], count]
            end
          end
        end
      end
    end

    best_play
  end


end

