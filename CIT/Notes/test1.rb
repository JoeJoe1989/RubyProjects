require 'nokogiri'
require 'open-uri'

page = "http://www.cis.upenn.edu/~swapneel/test.html"

doc = Nokogiri::HTML(open(page))

# doc.css("table tr td").each do |row|
#   p row.text
# end

filter = "table tr td"
temp = doc.css(filter)
new = temp[1,3]
puts new.size
puts new
