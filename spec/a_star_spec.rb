require 'spec_helper'

describe 'a* pathfinding algorithm' do

  describe 'picking lowest score' do
  	scores = { a: 1, b: 2, c: 3, d: 1}
  	key = Pathfinding::Strategy::AStar.pick_lowest_score( scores )
  	key.first.should == :a
  end

  specify 'solving a simple maze' do
    maze = Maze.new("s.\n.g")
    steps = Pathfinding::Strategy::AStar.solve maze
    steps.collect{|s| s.coord }.should eql [[0, 0], [0, 1], [1, 1]]
  end

  specify 'solving a 3x3 simple maze' do
    maze = Maze.new("s..\n...\n..g")
    steps = Pathfinding::Strategy::AStar.solve maze
    steps.collect{|s| s.coord }.should eql [[0, 0], [0, 1], [0, 2], [1, 2], [2, 2]]
  end

  specify 'solving a maze with obstacles' do
  	maze = Maze.new("s..\n...\n.*g")
  	steps = Pathfinding::Strategy::AStar.solve maze
  	steps = steps.collect{|s| s.coord}
  	steps.should_not include([1, 2])
  	steps.should eql [[0, 0], [0, 1], [1, 1], [2, 1], [2, 2]]
  end

  specify 'solving a complicated maze' do
  	maze = Maze.new("s*g.\n..*.\n*.*.\n*...")
  	steps = Pathfinding::Strategy::AStar.solve maze
  	steps = steps.collect{|s| s.coord}
  	steps.should eql [[0, 0], [0, 1], [1, 1], [1, 2], [1, 3], [2, 3], [3, 3], [3, 2], [3, 1], [3, 0], [2, 0]]
  end

  specify 'should fail if there is no solutions' do
  	maze = Maze.new("s*g.\n..*.\n*.**\n*...")
  	expect{ Pathfinding::Strategy::AStar.solve maze }.to raise_error
  end

end
