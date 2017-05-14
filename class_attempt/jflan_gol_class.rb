class World
  attr_accessor :width, :height, :population_density, :style, :grid

  def initialize(height, width, population_density, style)
    @width = width
    @height = height
    @population_density = population_density
    @style = style
    @grid = []
  end

  def create_world
    height.times do |row|
      row = []
      width.times do |column|
        column = (rand(population_density) == 0 ? 1 : 0)
        # allows the user to choose the density of the initilal population
        row.push(column)
      end
      grid.push(row)
    end
    grid
  end

  def to_s
    # puts "\e[H\e[2J"
    system("clear")
    grid.map do |row|
      row.map do |column|
        column == 1 ? style : " "
      end.to_a.join(" ")
    end.join("\n")
  end

  def add_cells(row_index, col_index)
    if col_index == 0
      grid[row_index][col_index] + grid[row_index][col_index + 1]
    elsif col_index == (grid[row_index].length - 1)
      grid[row_index][col_index - 1] + grid[row_index][col_index]
    else
      grid[row_index][col_index - 1] + grid[row_index][col_index] + grid[row_index][col_index + 1]
    end
  end

# The three methods below define the cell neighbors with exceptions to respect array bounds

  def row_above(row_index, col_index)
    return 0 if row_index == 0
    add_cells((row_index - 1), col_index)
  end

  def row_below(row_index, col_index)
    return 0 if row_index == (grid.length - 1)
    add_cells((row_index + 1), col_index)
  end

  def same_row(row_index, col_index)
    add_cells(row_index, col_index) - grid[row_index][col_index]
  end


  def cell_neighbors(row_index, col_index)
    row_above(row_index, col_index) + same_row(row_index, col_index) + row_below(row_index, col_index)
  end

  def next_generation
    grid.map.with_index do |row_of_cells, row_index|
      row_of_cells.map.with_index do |cell, col_index| # cell is already 0, 1 since it's a[row][cell]
        neighbors = cell_neighbors(row_index, col_index)
        if neighbors == 3
          grid[row_index][col_index] = 1
        # 3 live neighbors => the cell resurrects or stays alive
        elsif (neighbors == 2)
          grid[row_index][col_index]
        # 2 live neighbors doesn't change the status
        else
          grid[row_index][col_index] = 0
        # Everything else dies :(
        end
      end
    end
  end

end

puts "How tall do you want your world to be? "
height = gets.chomp.to_i
puts "How wide do you want your world to be? "
width = gets.chomp.to_i
puts "How populated? (1 is very, 10 is sparse) "
population_density = gets.chomp.to_i
puts "How do you want your cells displayed? Fancy, Béyßiq, or GAIYE AF? "
answer = gets.chomp.downcase
  if answer == "fancy"
    style = "\u{1f957}"
  elsif answer == "gaiye af"
    style = "\u{1F984}"
  else
    style = "*"
  end
world = World.new(height, width, population_density, style)
world.create_world
puts world

loop do
  sleep (0.2)
  world.next_generation
  puts world
end



