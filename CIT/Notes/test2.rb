def try
  if block_given?
    yield
  else
    puts "no block"
  end
end

try do
  puts "1"
end # => "hello"

locations = ['Pune', 'Mumbai', 'Bangalore']

locations.each do |loc|
  puts 'I love ' + loc + '!'
  puts "Don't you?"
end

digits = -1..9
