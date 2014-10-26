require 'open-uri'

my_uri = "http://www.cis.upenn.edu/~swapneel/test.html"

open(my_uri) do |site|
  site.read.scan(/<>/)

  p site.status
  p site.last_modified
  p site.content_type
  p site.charset

  site.each_line do |line|
    p line
  end
end

