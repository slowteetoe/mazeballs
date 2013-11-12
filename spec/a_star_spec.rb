require 'spec_helper'

describe "a* pathfinding algorithm" do

	it "should start out with an empty closed set and the open set consisting of the start" do
    m = Maze.new "s.\n.."
    Pathfinding::Strategy::AStar.new m
    m.starting_location.should eql [0,0]
  end
end