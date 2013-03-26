require 'rspec'

require 'board'
require 'piece'

describe Board do
  subject(:board) { Board.new }

  describe "#initialize" do

    it "contains 8 rows" do
      board.rows.count.should equal(8)
    end

    it "has rows containing 8 columns" do
      board.rows.each do |row|
        row.count.should equal(8)
      end
    end

  end

  describe "#first_pieces" do

    it "places the initial four game pieces" do
      board.first_pieces
      board.rows[3][3].color.should == :red
      board.rows[3][4].color.should == :blue
      board.rows[4][4].color.should == :red
      board.rows[4][3].color.should == :blue
    end

  end

  let(:bad_pos) { [9,0] }
  let(:good_pos) { [7,7] }

  describe "#in_bounds?" do

    it "false if the position is out of bounds" do
      board.in_bounds?(bad_pos).should be_false
    end

    it "true if the position is in bounds" do
      board.in_bounds?(good_pos).should be_true
    end
  end

  describe "#place_piece" do
    it "places a piece of a given color at a given position" do
      board.place_piece(:red, [1,2])
      board.rows[1][2].color.should == :red
      board.rows[1][2].position.should == [1,2]
    end
  end

  describe "#pieces_to_flip" do

    it "returns arrays when play is valid" do
      board.pieces_to_flip([5,3], :red).should == [[4,3]]
    end

  end

end