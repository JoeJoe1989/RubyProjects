#1
=begin 
The intersperse function takes an element and a list 
and `intersperses' that element between the elements of the list. 
For example, intersperse ',' "abcde" == "a,b,c,d,e"
=end
def intersperse (s,str)
	return "" if str.empty?
	result = ""
	str.each_char do |c|
		result = result + c + s
	end
	result[0...-1]
end

def intersperse2 (s,str)
	str.chars.reduce {|buf, elt| buf = buf + s + elt}
end

p intersperse2(',', 'ds')
#3
=begin 
takeWhile, applied to a predicate p and a list xs, 
returns the longest prefix (possibly empty) of xs of elements 
that satisfy p:
For example, 
     takeWhile (< 3) [1,2,3,4,1,2,3,4] == [1,2]
     takeWhile (< 9) [1,2,3] == [1,2,3]
     takeWhile (< 0) [1,2,3] == []
=end
def takeWhile(pred, array)
  array.reduce([]) do |buf, elt|
    return buf unless pred.call(elt)
    buf.push(elt)
  end
end

# puts takeWhile((< 3), [1,2,3,4,1,2,3,4])


#4
=begin
find pred lst returns the first element of the list that 
satisfies the predicate.
for example: 
    find odd [0,2,3,4] returns 3
=end
def find (pred, array)
   array.reduce(nil) {|buf, elt| return elt if pred.call elt}
end

def find_index (pred, array)
  index = 0
  array.reduce(nil) do |buf, elt|
    return index if pred.call elt
    index += 1

  end
end


def any(pred, array)
	array.reduce(false) {|buf, elt| buf  = buf or pred.call elt}
end #can try to return as soon as you find a element satisifying the predicate

def all(pred, array)
	array.reduce(true) {|buf, elt| buf = buf and pred.call elt}
end


puts find_index proc {|a| a % 2 == 0}, [1,2]
puts takeWhile(proc {|a| a < 3}, [1,2,3,4,1,2,3,4]).inspect

