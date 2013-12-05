require 'artoo'

connection :sphero, adaptor: :sphero, port: '4560'
device :sphero, driver: :sphero

FORWARD = 0
BACK = 180
RIGHT = 90
LEFT = 270

DIRECTIONS = [ FORWARD, BACK, RIGHT, LEFT ]

def move_randomly
  sphero.roll 60, DIRECTIONS.sample
end

work do
  10.times do
    puts "Rolling..."
    move_randomly
    sleep 4
  end
end
