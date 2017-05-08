################################################################################
# This program requires toilet. To install on mac:
# $ brew install toilet
# If you don't want to the ridiculous fun times output, please run jflan_gol_basic.rb instead.
# This program is very strongly based off the following:
# https://codereview.stackexchange.com/questions/25850/ruby-game-of-life-with-matrices
# Larger boards (40x40, 60x60) work better, as do middle population densities (4-6).
# These combos give a great combination of gliders, blinkers, and pulsars.
################################################################################

require 'Matrix'

class Matrix
  def stack_neighbors(row_size, column_size)
    Matrix[
      *row_vectors.map do |row|
        row.to_a.rotate(row_size)
      end.rotate(column_size)
    ]
  end
end

class World
  attr_reader :height, :width

  def initialize(world)
    @world = world
    @height = world.row_count
    @width = world.column_count
  end

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
Choose a number from 1 to 10, with 2 being NYC and 10 being Mars.
Note: Choosing 1 will basically yield a dystopian tragedy and everyone will die immediately.
    EOF
    population_density = gets.chomp.to_i
    puts "Type 'x' and hit ENTER at any time to destroy your world. #youmonster "
    sleep(2)
    puts "Scraping locker rooms . . ."
    sleep(2)
    puts "WOOT! Ready to play God in"
    sleep(2)
    system("clear")
    5.downto(1) do |n|
      system("toilet #{n}...")
      sleep(1)
    end
    system("clear")
    system("toilet --filter gay LET THERE")
    system("toilet --filter gay BE LYFE!")
    sleep (2)
    system("clear")
    world = Matrix.build(size) {rand(population_density) == 0 ? 1 : 0}
    new(world)
  end

  def to_s
    @world.row_vectors.map do |row|
      row.map do |cell|
        cell == 1 ? "\u{1f4a5}" : "\u{26ab}"
      end.to_a.join(" ")
    end.join("\n")
  end

  def neighbor_counts
    [-1,0,1].product([-1,0,1]).map do |row, col|
      @world.stack_neighbors(row, col)
    end.reduce(:+)
  end

  def next_generation
    world_status = neighbor_counts.map.with_index do |count, idx|
      count == 3 || count == 4 && @world[idx / width, idx % width] == 1 ? 1 : 0
    end
    World.new(world_status)
  end
end



################################################################################
############################ PROGRAM STARTS HERE ###############################
################################################################################

new_world = World.create_world

Thread.new do
  while line = STDIN.gets
    break if line.chomp == 'x'
  end
  exit
end

loop do
  puts new_world
  sleep(0.2)
  system("clear")
  new_world = new_world.next_generation
end
