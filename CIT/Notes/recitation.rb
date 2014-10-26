
def fun(a,b)
  # x = if a > b then 4 else 5 end
  #
  # f ||= 5
  # puts f

  x = 3 unless a == b
  x ||= 7
  puts x
end

def fun1(array)
  array.any? {|e| e==5}
  #array.all? {|e| e==5}

end

pred = proc {|x| x == 2}
p [1,2,3].reduce(false){|red, ele| red or pred.call(ele)}

p [1,2,3].reduce(false){|red, ele| red or (ele == 2)}
p [1,2,3].reduce(true){|red, ele| red and (ele == 2)}
p [1,2,5].map{|x| x == 5}.reduce(false){|a,b| a or b}




