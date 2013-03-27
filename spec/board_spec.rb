require 'rspec'

require 'board'
require 'piece'

describe Board do
  subject(:board) { Board.new }

  describe "#initialize" do

    it "contains 8 rows" do
      board.rows.count.should == 8
    end

    it "has rows containing 8 columns" do
      board.rows.each do |row|
        row.count.should == 8
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
      board.place_piece([1,2], :red)
      board.rows[1][2].color.should == :red
      board.rows[1][2].position.should == [1,2]
    end
  end

  describe "#valid_move?" do

    it "returns false if play is invalid" do
      board.valid_move?([1,2], :red).should be_false
    end

    it "returns false if play is invalid" do
      board.valid_move?([4,5], :blue).should be_true
    end
  end


  describe "#pieces_to_flip" do

    it "returns arrays when play is valid" do
      board.pieces_to_flip([5,3], :red).should == [[4,3]]
    end

    context "with more pieces" do
      before(:each) do
        board.place_piece( [2,2], :blue )
        board.place_piece( [4,6], :blue )
        board.place_piece( [5,5], :red )
        board.place_piece( [5,6], :red )
      end

      it "returns arrays when play is valid" do
        board.pieces_to_flip([6,6], :blue).should == [[5,6],[5,5],[4,4],[3,3]]
      end
    end
  end
end


