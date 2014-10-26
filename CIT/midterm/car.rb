=begin

Hey guys this is the code that I planned for us to use in the recitation today when I had my car example.  
We have a car class and then a method that lets us create a sort of garage like array of cars.  This is actually the 
homework assignment I had when I first learned about classes in ruby.  There was more with editing the cars in the garage
but I took that out because I didn't think we'd get to it in the recitation.  Good luck studying for the midterm!!

Josh	
	
=end

=begin Write a ruby class for a Car.  Include instance variables 
for color, price, make, and model with getter/setter methods for each of these variables.  
Keep track of the total number of cars created.   
=end

class Car

	attr_accessor :color, :price, :make, :model

	@@count = 0
	
	def initialize(color, price, make, model)
		@color = color
		@price = price
		@make = make
		@model = model
		@@count = @@count + 1
	end	

	def to_s
		"This is a #{color} #@make #@model that you bought for $#@price."
	end	

	def self.cars_count
		@@count
	end

	def self.lower_count
		@@count = @@count - 1
	end	

end	


def start

	quit = false
	garage = []

	until (quit)

		puts "\nWelcom to Car List! \n Choose one of the following to get started."
		puts "(1) Add a car"
		puts "(2) Show a car (by index)"
		puts "(3) Remove a car (by index)"
		puts "(4) Get total number of saved cars"
		puts "(5) Quit"

		option_select = gets.chomp.to_i

		if (option_select == 1)
			addCar!(garage)
		elsif (option_select == 2)
			showCar(garage)
		elsif (option_select == 3)
			deleteCar!(garage)
		elsif (option_select == 4)
			print "There are "
			print Car.cars_count
			print " cars in the garage!\n"
	 	elsif (option_select == 5)
			puts "Quitting the program!"
			quit = true
		else
			puts "invalid please try again"
		
		end
	
	end
end



def addCar!(carlist)
	puts "What should the color of the car be?"
	color = gets.chomp
	puts "what is the price?"
	price = gets.chomp.to_i
	puts "what is the make?"
	make = gets.chomp
	puts "What is the model?"
	model = gets.chomp

	ev = Car.new(color, price, make, model)
	carlist.push(ev)

end

def showCar(carlist)
	puts "What is the index of the car you want to see?"
	index = gets.chomp.to_i

	if (index < carlist.length && index >= 0)
		car = carlist[index]
		puts car
	else
		puts "Invalid Index!! Please try again!"
	end

end	

def deleteCar!(carlist)
	puts "What is the index of the car that you sold?"
	index = gets.chomp.to_i

	if (index < carlist.length && index >= 0)
		carlist.delete_at(index)
		Car.lower_count
	else
		puts "Invalid Index!! Please try again!"
	end
	carlist
end

start

