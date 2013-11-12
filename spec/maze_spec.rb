require 'spec_helper'

describe 'mazes' do

  it "should reject mazes with incorrect number of cells" do
    expect { Maze.new ".\n.." }.to raise_error
  end

  it "should accept a maze description" do
    m = Maze.new "..\n.."
    m.to_ascii.should eql "..\n.."
  end

  it "should report the character at a given position" do
    m = Maze.new "!@\n*^"
    m.at(0,0).to_s.should eql "!"
    m.at(1,1).to_s.should eql "^"
    expect { m.at(2,2).to_s }.to raise_error
  end

  describe "calculating simple distances" do
    $m = Maze.new "...\n...\n..."
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