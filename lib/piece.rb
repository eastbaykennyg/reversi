class Piece

  attr_accessor :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def change_color
    @color == :red ? @color = :blue : @color = :red
  end

end