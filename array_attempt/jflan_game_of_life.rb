# Defining ALL the methods

def new_grid
  subgrid = []
  grid = []
  10.times {subgrid.push(0)}
  10.times {grid.push(subgrid)}
  puts "Grid:"
  grid.each {|cell| print "#{cell}\n"}
  return grid
end

def random_colony(grid)
  x = rand(1..(grid.length-2)) #rows
  y = rand(1..(grid.length-2)) #columns
  colony = [
    [grid[x-1][y-1], grid[x-1][y], grid[x-1][y+1]], #[0] = Row 1
    [grid[x][y-1], grid[x][y], grid[x][y+1]], #[1] = Row 2
    [grid[x+1][y-1], grid[x+1][y], grid[x+1][y+1]] #[2] = Row 3
  ]
  colony.each_index do |row|
    colony[row].each_index {|column| colony[row][column] = rand(0..1)}
  end
  puts "Colony:"
  colony.each {|row| print "#{row}\n"}
  return colony

end

def initial_primary_cell_status(colony)
  primary_cell = colony[1][1]
  if primary_cell == 1
    puts "The primary cell is alive!"
  else
    puts "The primary cell is dead."
  end
  return primary_cell
end

def alive_neighbor_count(colony, primary_cell)
  alive = 0
  colony.each_index do  |row|
    colony[row].each_index do |column|
      if colony[row][column] == 1
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

###############################
##### Program Starts Here #####
###############################

puts "=" * 40 # separate method definition from code that runs
puts "\n"

grid = new_grid # creates a new grid, user size input coming soon

spacing

colony = random_colony(grid) # generates a random colony and assigns random life values

puts "\n"

primary_cell = initial_primary_cell_status(colony) # define and assess status of the primary cell

puts "\n"

cells_alive = alive_neighbor_count(colony, primary_cell)

spacing

primary_cell_change?(colony, primary_cell, cells_alive)

spacing
