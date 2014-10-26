module LazyPrime
class Prime
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

end

end

p LazyPrime::Prime.new.compute_all_primes.first(10)