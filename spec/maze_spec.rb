require 'spec_helper'

describe 'dealing with mazes' do

  describe 'building the maze' do
    it 'should reject mazes with incorrect number of cells' do
      expect { Maze.new ".\n.." }.to raise_error
    end

    it 'should have a starting pt and goal' do
      m = Maze.new "s.\n.g"
      m.starting_location.should eql [0, 0]
      m.goal.should eql [1, 1]
    end

    it 'should accept a maze description' do
      m = Maze.new "s.\n.g"
      m.to_ascii.should eql "s.\n.g"
    end
  end

  describe 'checking contents of the maze' do
    it 'should report the character at a given position' do
      m = Maze.new "!g\ns^"
      m.at(0, 0).token.should eql '!'
      m.at(1, 0).token.should eql 'g'
      m.at(0, 1).token.should eql 's'
      m.at(1, 1).token.should eql '^'
      expect { m.at(2, 2).to_s }.to raise_error
    end
  end

  describe 'handling the contents of cells' do
    it 'should report that certain cells are impassable' do
      m = Maze.new "s.\n*g"
      token = m.at(0,1).token
      token.should eql '*'
      m.traversible?(token).should eql false
    end
  end

  describe 'calculating simple distances' do
    $m = Maze.new "...\ns..\n..g"
    it 'adjacent cells to the right should be 1 pt away' do
      $m.distance_between([0, 0], [0, 1]).should == 1
    end
    it 'adjacent cells below should be 1 pt away' do
      $m.distance_between([0, 0], [1, 0]).should == 1
    end
    it 'should be 2 pts away for a diagnal (since we are not permitting them)' do
      $m.distance_between([0, 0], [1, 1]).should == 2
    end
    it 'should be 1 pt away for an adjacent cell to the left' do
      $m.distance_between([0, 1], [0, 0]).should == 1
    end
  end

  describe 'getting neighbors for a empty maze' do
    $m = Maze.new "...\ns..\n..g"
    it 'should find [0, 0] neighbors' do 
      $m.neighbors_for([0, 0]).should eql [[1, 0], [0, 1]]
    end
    it 'should find [1,0] neighbors' do 
      $m.neighbors_for([1, 0]).should eql [[2, 0], [1, 1], [0, 0]]
    end
    it 'should find [2,0] neighbors' do
      $m.neighbors_for([2, 0]).should eql [[2, 1], [1, 0]]
    end
    it 'should find [0,1] neighbors' do
      $m.neighbors_for([0, 1]).should eql [[0, 0], [1, 1], [0, 2]]
    end
    it 'should find [1,1] neighbors' do
      $m.neighbors_for([1, 1]).should eql [[1, 0], [2, 1], [1, 2], [0, 1]]
    end
    it 'should find [2,1] neighbors' do
      $m.neighbors_for([2, 1]).should eql [[2, 0], [2, 2], [1, 1]]
    end
    it 'should find [0,2] neighbors' do
      $m.neighbors_for([0, 2]).should eql [[0, 1], [1, 2]]
    end
    it 'should find [1,2] neighbors' do
      $m.neighbors_for([1, 2]).should eql [[1, 1], [2, 2], [0, 2]]
    end
    it 'should find [2,2] neighbors' do
      $m.neighbors_for([2, 2]).should eql [[2, 1], [1, 2]]
    end
  end

  describe 'translating coords to directions' do
    it 'should indicate there is nothing to do if coords are empty' do
      Maze.coords_to_directions([]).should eql []
    end

    it 'should indicate there is nothing to do if there is only one coord' do
      Maze.coords_to_directions([[0, 0]]).should eql []
    end

    it 'should detect a northern movement' do
      Maze.coords_to_directions([[2, 2], [2, 1]]).should eql [:north]
    end

    it 'should translate a complicated set of coords to directions' do
      Maze.coords_to_directions([[0, 0], [0, 1], [1, 1], [1, 2], [1, 3], [2, 3], [3, 3], [3, 2], [3, 1], [3, 0], [2, 0]]).should eql [
        :south, :east, :south, :south, :east, :east, :north, :north, :north, :west
      ]
    end
  end

end
