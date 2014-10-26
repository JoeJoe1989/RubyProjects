def three_times
  yield
  yield
  yield
end

# three_times {puts 'Hello'}

def fib(max)
  i1, i2 = 1, 1

  while (i1 <=  max)
    yield i1
    i1, i2 = i2, i1 + i2
  end
end

fib(100) {|x| puts x}

fruits = ["strawberry", "mango", "avocado", "banana"]
fruits.each {|f| puts f}

fruits.each_with_index do |fruit, index|
  puts "Fruits #{fruit} is at index #{index}"
end

p Array.new(3) {Array.new(3)}
p Array.new(3) {Hash.new}
#p Array.new(3) { |index| Array.new({index})}

"cats and dogs" =~ /pattern you wanna match/
"dats is 88" =~/\d/ # any digit
"55 hello 44".match(/\d+(.*)(\d+)/) # greedy
"55 hello 44".match(/\d+(.*?)(\d+)/) #

"55 hello 44".sub(/h/, "*") # replace first pattern
"55 hello 44".gsub(/h/, "*") # replace all pattern




