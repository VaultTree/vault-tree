require 'minitest/spec'
require 'minitest/autorun'


describe '#pipe' do

  it 'pipes the output from one method to the input of the next' do
    result = pipe(5, through: [ :add_one, :add_two, :subtract_four, :add_ten])
    result.must_equal(14)
  end

  it 'it handles empty :through array' do
    result = pipe(5, through: [])
    result.must_equal(5)
  end
end

# pipe - express ruby behavior like unix pipes
#
# Examples:
#   pipe(5, through: [ :add_one, :add_two, :subtract_four, :add_ten])
#      => 14
#
#   pipe(5, through: [])
#      => 5
#
# original idea:
# http://developer.teamsnap.com/blog/2015/02/28/implementing-pipe-in-ruby-part-2/
def pipe(input, s = {through: []})
  s[:through].each {|mth| input = send(mth, input)}; input;
end

def add_one(a)
  return a + 1
end

def add_two(a)
  return a + 2
end

def subtract_four(a)
  return a - 4
end

def add_ten(a)
  return a + 10
end
