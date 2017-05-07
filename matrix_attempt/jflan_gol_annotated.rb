################################################################################
# This program requires toilet. To install on mac:
# $ brew install toilet
# If you don't want to the ridiculous fun times output, please run jflan_gol_basic.rb instead.
# This program is very strongly based off the following:
# https://codereview.stackexchange.com/questions/25850/ruby-game-of-life-with-matrices
################################################################################

################################################################################
# Common commands and terms in this file
# sleep(0.5) tells Ruby to pause or "sleep" for the value given in seconds
# system("clear") tells Ruby to run a normal bash command in the argument
# system("toilet") toilet is a program that takes a text argument and prints it
  # as a collection of smaller chracters and colors
# a vector is any given row/column in a Matrix
################################################################################

require 'Matrix'
# tells Ruby to include the class: Matrix

class Matrix
  # we need to modify the Matrix class by defining a new method
  def stack_neighbors(row_size, column_size)
    Matrix[
      *row_vectors.map do |row|
        row.to_a.rotate(row_size)
#Convert each row of the Matrix to an array
#Shift the position of the values in the new array (row_size) places
      end.rotate(column_size)
#Shift the position of the values in the new array (column_size) places
    ]
  end
end

class World
#create World class
  attr_reader :height, :width
  #makes @height and @width available outside of the class

  def initialize(world)
    @world = world
    @height = world.row_count
    @width = world.column_count
  end
#Matrix class has a predefined method for row and column count.

  def self.create_world
    system("clear")
    system("toilet WELCOME TO THE GAME OF LIFE!")
    sleep(1)
    puts  "It's time to get your petri dish on!"
    sleep(1)
    puts " . . . or petri square, rather."
    sleep(1)
    puts  "How many cells across would you like your World to be? "
    size = gets.chomp.to_i
    sleep(1)
    print <<-EOF
Great! Now, are you more of city boy or a 'get off my lawn' kinda gurl?
Choose a number from 1 to 10, with 1 being NYC and 10 being Mars.
Note: Choosing 1 will basically yield a dystopian tragedy and everyone will die immediately. "
    EOF
    population_density = gets.chomp.to_i
    puts "Type 'x' and hit ENTER at any time to destroy your world. #youmonster "
# As per the Thread instance on rb. 123-128
    sleep(2)
    puts "Scraping locker rooms . . ."
    sleep(2)
    puts "WOOT! Ready to play God in"
    sleep(2)
    system("clear")
# clears the screen
    5.downto(1) do |n|
      system("toilet #{n}...")
      sleep(1)
    end
# prints a dramatic count down using the toilet program
    system("clear")
    system("toilet --filter gay LET THERE")
    system("toilet --filter gay BE LYFE!")
    sleep (0.5)
    system("clear")
    world = Matrix.build(size) {rand(population_density) == 0 ? 1 : 0}
  # instantiates the [modified] Matrix class with the user input size as the dimensions
  # Matrix class allows for implied .each assignment with the rand block
  # rand(10) == 0 ? 1: 0 means that if the random number == 0, assign a value of 1.
      # If not, assign a value of 0.
  # rand(10) == 0 ~9% of the time. rand(1) == 0 50% of the time
      # A higher argument will generate a more sparse initial population
    new(world)
  # instantiates the World Class
  end

  def to_s #overrides to_s to use with puts world (rb. 133)
    @world.row_vectors.map do |row|
      row.map do |cell|
        cell == 1 ? "\u{1f4a5}" : "\u{26ab}"
# print the respective unicode values depending on the cell value
      end.to_a.join(" ")
# convert each row to an array, remove the standard [,] and separate each cell with a space
    end.join("\n")
# put each row on its own line
  end

  def neighbor_counts
    [-1,0,1].product([-1,0,1]).map do |row, col|
# creates a 2 element array of every possible combination of [-1,0,1] and [-1,0,1]
      @world.stack_neighbors(row, col)
# each of the above combinations is passed as the arguments for the stack_neighbors method
    end.reduce(:+)
# stack_neighbors shifts each row and creates stacks of "neighbors" in the same relative position
# reduce(:+) compresses these stacks and adds the values of each cell
# by putting each cell's neighbor into the targeted cell's position,
# we can easily add up how many neighbors are alive or "1"
  end

  def next_generation
    world_status = neighbor_counts.map.with_index do |count, idx|
      count == 3 || count == 4 && @world[idx / width, idx % width] == 1 ? 1 : 0
    end
# Equates neighbor_count return values with the game rules
# Since the neighbor_counts include the target cell, we can reduce 4 rules to 2
# If the neighbor_count equates with one of the conditions, the new value is 1, it not 0.
    World.new(world_status)
#instatiates the World class anew
  end
end #end of class



##########################################################
#################### PROGRAM STARTS HERE #################
##########################################################

new_world = World.create_world
#instantiates the class with user input for the necessary arguments.

Thread.new do
  while line = STDIN.gets
    break if line.chomp == 'x'
  end
  exit
end
# allows user to end the game by typing 'x' and pressing Enter rather than using ^C.


loop do
  puts new_world
    # starts the class instantiation
  sleep(0.2)
  system("clear")
  new_world = new_world.next_generation
    # redfines new_world as the return value of the next_generation method
end



################################################################################
# QUESTIONS AND CRITIQUES
# Can I modify it to allow users to select a certain initial pattern?
# Can I get it to stop and restart with standard user input (and remove the cursor)?
# Cells along the edge will use neighbors on the opposite side of the board.
# Can I separate out the user input section and class instantiation into design_world and create_world methods?
# Can I be more efficient with the user input section using blocks and loops?
# Is there a better way to get the population_density?
################################################################################


