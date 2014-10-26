
def check_anagram(str1_input, str2_input)
  str1_trim = str1_input.gsub(' ', '')
  str2_trim = str2_input.gsub(' ', '')

  return false unless str1_trim.length == str2_trim.length

  str1_final = str1_trim.chars
  str2_final = str2_trim.chars

  str1_final.each do |x|
    str2_final.each do |y|
      if y == x
        str1_final.delete(x)
        str2_final.delete(y)
      end
    end

  end

  # if str1_final.empty? and str2_final.empty?

    if str1_final.length == 0 and str2_final.length == 0
    return false
  else
    return true
  end


end

p check_anagram('josd e', 'e s jo')

def is_anagram?(first, second)
  first.downcase.gsub(' ', '').chars.sort ==
  second.downcase.gsub(' ', '').chars.sort
end
class Array
  def my_reject
    arr = []
    self.each do |x|
      array << x unless yield x
    end
    return arr
  end
end




