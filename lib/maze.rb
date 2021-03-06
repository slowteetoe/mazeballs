require 'cell'

class Maze

  attr_accessor :num_rows, :num_cols, :m, :starting_location, :goal

  DIRECTIONS = {
    north: [0, -1],
    east: [1, 0],
    south: [0, 1],
    west: [-1, 0]
  }

  ROCKS = '*'

  IMPASSABLE = [ROCKS]

  def initialize(descr)
    a = descr.split("\n")
    @num_rows = a.size
    @num_cols = a[0].size
    @m = Array.new(@num_rows) { Array.new(@num_cols) }

    a.each_with_index do |val, col|
      val.split('').each_with_index do |c, row|
        @m[row][col] = Cell.new(c, [row, col])
        @starting_location = [row, col] if c.eql? 's'
        @goal = [row, col] if c.eql? 'g'
      end
    end

    validate_maze_definition a
  end

  def distance_between(a, b)
    (b[0] - a[0]).abs + (b[1] - a[1]).abs
  end

  def valid_cell( (x,y) )
    return  x >= 0 && y >= 0 && x <= @num_rows - 1 && y <= @num_cols - 1
  end

  def neighbors_for( (x, y) )
    neighbors = []
    DIRECTIONS.values.each do |d|
      (dx,dy) = d
      candidate = [x + dx, y + dy]
      if valid_cell(candidate) && traversible?( at(candidate.first, candidate.last).token )
        neighbors << candidate
      end
    end
    neighbors
  end

  def traversible?( token )
    return !(IMPASSABLE.include? token)
  end

  def to_ascii
    maze = ''
    (0...@num_rows).each do |r|
      (0...@num_cols).each do |c|
        maze << @m[r][c].to_s
      end
      maze << "\n"
    end
    maze.chomp  # get rid of the trailing \n
  end

  def at(x, y)
    @m[x][y]
  end

  def self.coords_to_directions(coords = [])
    return [] if coords.empty? || coords.length < 2
    directions = []
    prev = nil
    coords.each do |this_coord|
      if prev.nil?
        prev = this_coord
        next
      end
      delta = [ (this_coord.first - prev.first), (this_coord.last - prev.last) ]
      directions << DIRECTIONS.key(delta)
      prev = this_coord
    end
    directions
  end

  private

    def validate_maze_definition(a)
      a.each do |r|
        fail 'All rows must have the same number of cells' if r.size != @num_cols
      end
      fail 'Must have a starting node (the s character)' if @starting_location.nil?
      fail 'Must have a goal node (the g character)' if @goal.nil?
    end

end
