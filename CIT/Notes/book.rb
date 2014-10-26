class Book
  include Comparable

  attr_reader :isbn, :price
  attr_writer
  attr_accessor :name
  @@count = 0

  EUROUSD = 1.27

  def initialize(name, isbn, price)

    @name = name
    @isbn = isbn
    @price = Float(price)
    @@count += 1
  end

  def Book.count
    @@count
  end

  def to_s
    'Name: #{@name}, ISBN: #@isbn, Price: #@price'
  end

  def price_in_eur
    @price / EUROUSD

  end

  def price_in_eur=(eur)
    @price = eur * EUROUSD

  end

  def <=>(other)
    # @isbn <=> other.isbn # ascending order
    other.isbn <=> @isbn # descending order

  end

  # def name
  #   @name
  # end
  #
  # def name= (name)
  #   @name = name
  # end
end

p Book.count

p1 = Book.new('Harry Potter', 0, 54.5)
# puts p1 # just memory addr but will call to_s
# p p1 # other info as well
# p1.name = 'jose' # get rid of ()
# p1.name=('john')

# p Book::EUROUSD = 4 # will get warning
p2 = Book.new('Will', 33, 44)
p3 = Book.new('jose', 2, 330)

# p Book.count
#
# my_list = [p1, p2, p3]
# p my_list
# p my_list.sort!
# # p1.price_in_eur = 50
# p my_list

