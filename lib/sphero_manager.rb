require 'artoo'

connection :sphero, adaptor: :sphero, port: '4560'
device :sphero, driver: :sphero

DIRECTIONS = {
  north: 0, south: 180, east: 90, west: 270
}

def move(direction = :north, amount = 25)
  sphero.roll amount, DIRECTIONS[direction]
  sleep 3
end

def move_randomly
  move DIRECTIONS.sample
end

def move_in_a_square
  puts "Square Dance!!"
  [:north, :east, :south, :west].each {|d| move d, 120; sleep 4 }
end

def calibrate
  (1..10).each do |v|
  	v = v * 5
  	puts "Moving #{v} units"
  	move FORWARD, v
	sleep 5
  	puts "Returning to start"
  	move BACK, v
  	puts "Next attempt in 3 secs"
  	sleep 10 
  end
end

def traverse_maze( instructions = [] )
  instructions.each do |i|
    puts "Rolling #{i}"
    move i, 50
  end
  puts "All done."
end

work do
  sphero.roll 0, 20
  sleep 10
  sphero.set_color(173,255,47)
  #move_in_a_square
  # move FORWARD, 20
  # calibrate
  traverse_maze [:south, :east, :south, :south, :east, :east, :north, :north, :north, :west]
  sleep 5
  sphero.set_color(0,0,0)
  sphero.roll 0, 0
end
