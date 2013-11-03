class Maze

  attr_accessor :rows, :cols, :m

	def initialize(rows=0, cols=0)
    @rows = rows
    @cols = cols
    @m = Array.new(rows) { |i| Array.new(cols) {|c| '.' } }
  end

  def initialize!(descr)
    a = descr.split("\n")
    rows = a.size
    cols = a[0].size
    a.each do |r|
      raise "All rows must have the same number of cells" if r.size != cols
    end
    m = Maze.new(rows, cols)
    a.each_with_index do |val, row|
      val.split("").each_with_index do |c, col|
        m.m[row][col] = c
      end
    end
    m
  end

  # this assumes all points are reachable
  def distance_between(a, b)
    (b[0] - a[0]).abs + (b[1] - a[1]).abs
  end

  def to_ascii
    maze = ""
    (0...@rows).each do |r|
      (0...@cols).each do |c|
        maze << @m[r][c]
      end
      maze << "\n"
    end
    maze.chomp  # get rid of the trailing \n
  end

  def at(x,y)
    @m[x][y]
  end

  private

end