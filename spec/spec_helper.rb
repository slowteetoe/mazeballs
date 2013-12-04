$LOAD_PATH << '../lib'

require 'maze'
require 'a_star'

RSpec.configure do |c|
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
end