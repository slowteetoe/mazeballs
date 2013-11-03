require 'spec_helper'

describe 'mazes' do
	it "create a symetrical empty maze" do
    m = Maze.new(2,2)
    m.rows.should eql 2
    m.cols.should eql 2
  end

  it "create an asymetrical empty maze" do
    m = Maze.new(2,5)
    m.rows.should eql 2
    m.cols.should eql 5
  end

  it "should display an empty 2x3 maze" do
    Maze.new(2,3).to_ascii.should eql "...\n..."
  end

  it "should display an empty 5x5 maze" do
    Maze.new(5,5).to_ascii.should eql ".....\n.....\n.....\n.....\n....."
  end

  it "should reject mazes with incorrect number of cells" do
    expect { Maze.new.initialize!(".\n..") }.to raise_error
  end

  it "should accept a maze description" do
    m = Maze.new.initialize!("..\n..")
    m.to_ascii.should eql "..\n.."
  end

  it "should report the character at a given position" do
    m = Maze.new.initialize!("!@\n*^")
    m.at(0,0).should eql "!"
    m.at(1,1).should eql "^"
    expect { m.at(2,2) }.to raise_error
  end

  describe "calculating simple distances" do
    $m = Maze.new(10,10)
    it "adjacent cells to the right should be 1 pt away" do
      $m.distance_between( [0,0], [0,1] ).should == 1
    end
    it "adjacent cells below should be 1 pt away" do
      $m.distance_between( [0,0], [1,0] ).should == 1
    end
    it "should be 2 pts away for a diagnol (since we're not permitting them)" do
      $m.distance_between( [0,0], [1,1] ).should == 2
    end
    it "should be 1 pt away for an adjacent cell to the left" do
      $m.distance_between([0,1], [0,0]).should == 1
    end
  end

end