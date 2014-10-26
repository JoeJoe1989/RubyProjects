require 'nokogiri'
require 'open-uri'

class WorldFactBook
  PAGE_URL = "http://www.cis.upenn.edu/~swapneel/test.html"

  def initialize
    doc = Nokogiri::HTML(open(PAGE_URL))
    filter = "table tr td"
    @country_info = doc.css(filter)[0]
    p "hello"

  end

  def get_country_info
    @country_info
  end

  def set_country_info(country_info)
    @country_info = country_info
  end

end

world_fact = WorldFactBook.new
country_info = world_fact.get_country_info
p country_info.text

a = ['EARTH', 'joseph']
p a.any? {|y| y.match(/[Ee]arthquake|EARTHQUAKE/)}

# b = "lowest point: Laguna del Carbon -105 m (located bet"
# c = "lowest point:Cerro Aconcagua 6,962 m (located"
# puts b.match(/(-?\d+\.?\d+)/)
#
# out = c.match(/(-?\d+,?\d+)/)
#
# s = out[0].gsub(/,/, ".")
# puts s.to_f * 1000

b = "jose 32 00 S, 44 00 E"
out = b.match(/(\d{2} \d{2} )(S)(,)( \d{2} \d{2} )(E)/)
puts out[2],out[5]

a = [1,2,3,1]
puts a.find_index(a.min)

b = "56,554,110  (July 2013)"
puts b.match(/(\d|,)+/)[0].gsub(/,/, "")

b = "34.578 billion kwh"
puts b.match(/\d+(\.)?\d+/)[0].to_f * 100

# b = [['jo', 5], ['ss', 1], ['dd',40]]
# b.sort! { |a,b| a[1] <=> b[1] }
# p b[0..1]

s = 'lowest point: <spanttom;">Riu Runer -83,440 m</span>'
# p s.match(/(.*>\D+?)(-?\d+,?\d+)/)[2].gsub(/,/,".").to_f * 1000

s = 'lowest point: <span class="category_data" style="font-weight:normal; vertical-align:bottom;">Amu Darya 258 m</span>'
p s.match(/(.*>\D+?)(-?\d+,?\d*)/)[2].gsub(/,/,".").to_f * 1000

s = 'note - the Ministry of Justice licensed 84 political parties as of December 2012'
p s.match(/(.*\s)(\d+)(\s)/)[2]

s = 'Sunni Muslim 80%, Shia Muslim 19%, other 1%'
num = s.scan('%').length
# p s.match(/(\D+\d+%,)+(\D+\d+%)/).captures[0]
# p s.match(/(.*?%)+/)[0]
p s.split(', ')

def variable_args(*more)
  puts more[0]
end

# call it
variable_args('south america')



def factorial_iterative(num)
  factorial = 1

  2.upto(num) {|value| factorial = factorial * value}

  return factorial
end

def factorial_func(num)

  return 1.upto(num).reduce(1) do |res, elt|
    res *= elt
  end

 end

p factorial_func(4)

def compute_sqr(num)
  num.lazy.map { |elt| elt ** 2}
end

p compute_sqr((1..100)).first(10)

def str_test (str)
  str.chars { |x| }
end

str_test('joseph')

