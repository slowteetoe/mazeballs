class Cell

  attr_accessor :token

  def initialize(token = ".")
    @token = token
  end

  def to_s
    token
  end

end