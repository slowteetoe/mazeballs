class Cell
  attr_accessor :token, :fscore, :parent, :coord

  def initialize(token = '.', coord)
    @token = token
    @coord = coord
  end

  def details
	"#{coord} : #{token}, parent is #{parent}"
  end

  def to_s
    @token
  end
end
