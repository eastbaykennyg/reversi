require 'rspec'

require 'board'
require 'piece'

describe Piece do
  let(:pieces) do
    pieces = [
      Piece.new( :red, [3,3]),
      Piece.new( :blue, [3,4])
      ]
  end
  let(:colors) { [:red, :blue] }

  describe "#initialize" do

    its "color is either red or blue" do
      pieces.each do |piece|
        colors.should include piece.color
      end
    end

    its "position is an array of 2" do
      pieces.each do |piece|
        piece.position.count.should equal(2)
      end
    end

  end

  describe "#color_change" do

    it "color flips between red and blue" do
      pieces.each do |piece|
        before_color = piece.color
        piece.change_color
        piece.color.should_not == before_color
      end
    end
  end


end