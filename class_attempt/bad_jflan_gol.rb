# Defining ALL the methods

require 'Matrix'

class World

  def initialize
    @grid = Array.new(10){Array.new(10)}
    @colony = Array.new(8)
    @r = Array.new # row
    @c = 0 # column
  end

  def populate_new_world
    (0...10).each do |row|
      (0...10).each do |cell|
        @grid[row][cell]= [0, 1].sample
      end
    end
    @grid.each {|row| print "#{row}\n"}
    @grid
  end

  def puts_colony
    print @colony
  end

  def row
    @grid.each do |r|
      print r.find_index
    end
  end

  def random_colony(grid)
    @grid.each_index do |x|
      @grid[x].each_index do |y|
          @colony.push(
            @grid[x-1][y-1])
            # @grid[x-1][y], @grid[x-1][y+1], #[0] = Row 1
            # @grid[x][y-1], @grid[x][y+1], #[1] = Row 2
            # @grid[x+1][y-1], @grid[x+1][y], @grid[x+1][y+1] #[2] = Row 3
            # )
      end
    end
    puts "Colony:"
    @colony.each {|row| print "#{row}\n"}
    return @colony
  end

  def initial_primary_cell_status(grid)
    primary_cell = @grid[rand(0..@grid.length)][rand(0..@grid.length)]
    if primary_cell == 1
      puts "The primary cell is alive!"
    else
      puts "The primary cell is dead."
    end
    return primary_cell
  end

  def neighborhood
    neighbors = []
      neighbors.push(@world.cell_at(self.x-1, self.y-1))
      neighbors.push(@world.cell_at(self.x-1, self.y))
      neighbors.push(@world.cell_at(self.x-1, self.y+1))

      neighbors.push(@world.cell_at(self.x, self.y - 1))
      neighbors.push(@world.cell_at(self.x, self.y + 1))

      neighbors.push(@world.cell_at(self.x + 1, self.y - 1))
      neighbors.push(@world.cell_at(self.x + 1, self.y))
      neighbors.push(@world.cell_at(self.x + 1, self.y + 1))
    return neighbors
  end

  def alive_neighbor_count(grid, primary_cell)
    alive = 0
    grid.each_index do  |row|
      grid[row].each_index do |column|
        if grid[row][column] == 1
          alive += 1
        end
      end
    end
    alive -= 1 if primary_cell == 1 # excludes primary_cell if alive
    puts "And has #{alive} Alive Neighbors"
    return alive
  end

  def primary_cell_change?(colony, primary_cell, cells_alive)
    if primary_cell == 1
      if cells_alive == 2 || cells_alive == 3
        puts "Rule 2: Primary Cell is alive!"
      else
        primary_cell = 0
        puts "Rule 1 and 3: Primary Cell is dead!"
      end
    else
      if cells_alive == 3
        primary_cell = 1
        puts "Rule 4: Primary Cell is alive!\n"
      else
        puts "Rule 4 (negated): Primary Cell is dead!"
      end
    end
    puts "\nResult:"
    colony.each {|row| print "#{row}\n"}
    return primary_cell
  end

  def spacing #output spacing and division
    puts "\n" + ("-" * 40) + "\n"
    # puts "-" * 40
    # puts "\n"
  end

end # end of class

###############################
##### Program Starts Here #####
###############################

puts "=" * 40 # separate method definition from code that runs
puts "\n"

world = World.new
world.populate_new_world  # creates a new grid, user size input coming soon
world.puts_colony
world.row


# spacing

# colony = random_colony(grid) # generates a random colony and assigns random life values

# puts "\n"

# primary_cell = initial_primary_cell_status(colony) # define and assess status of the primary cell

# puts "\n"

# cells_alive = alive_neighbor_count(colony, primary_cell)

# spacing

# primary_cell_change?(colony, primary_cell, cells_alive)

# spacing
