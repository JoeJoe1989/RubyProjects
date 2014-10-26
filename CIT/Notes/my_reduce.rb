class Range
  def my_reduce(*input)
    num_drop = 0
    if input.length == 0
      sum = self.first
      num_drop = 1
    else
      sum = input[0]
    end

    self.drop(num_drop).each do |x|
      sum = yield sum, x
    end
    return sum

  end
end

p (1..5).reduce {|sum, num| sum = sum + num}

p (1..5).my_reduce(0) {|sum, num| sum = sum + num}

class Array
  def my_reject
    out = []
    self.each do |x|
      out.push(x) if yield x
    end
    return out
  end

end
p [1,2,3,4,5].my_reject{ |x| x % 2 == 0}
