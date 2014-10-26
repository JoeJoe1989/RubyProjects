numbers = Array.new(10) {rand(1..100)}

p numbers
# squares = []
# numbers.each do |num|
#   squares << num ** 2
# end

# numbers.map do |num|
#   num ** 2
# end

# squares = numbers.map {|num| num ** 2}
#
# p squares

selected = numbers.select {|num| num % 2 ==0}
p selected

# total_sum = numbers.reduce(0) {|sum, num| sum = sum * num}

numbers.reduce(:*)

total_count = numbers.reduce(0) {|sum| sum = sum + 1}
p total_count

# lazy evaluation
def is_prime? (number)
  if number < 2 then
    return false
  else
    2.upto(Math.sqrt(number)) do |x|
      if number % x ==0 then
        return false
      end
    end
    return true
  end
end

def compute_all_primes
  (1..Float::INFINITY).lazy.select do |x|
    is_prime?(x)
  end
end

# first 100 prime numbers
# p compute_all_primes.first(10)

# p (1..Float::INFINITY).lazy.select {|x| is_prime?(x)}.first(15)
r = 1..Float::INFINITY
p r.lazy.map { |x| x * 10 }.first(5)




