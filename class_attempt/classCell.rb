

class Cell
  attr_reader :world, :x, :y

  def initialize(world, x, y)
    @world = world
    @x = x
    @y = y
    @alive = [true, false].sample
  end

  def show_cell
    puts self.inspect
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

  def alive_neighbors
    self.neighbors.select do |neighbor|
      neighbor.live?
    end
  end

  def toggle
    @alive = !@alive
  end

  def shows
    self.each do
      if @alive
        print "*"
      else
        print " "
      end
    end
  end


end

cell_test = Cell.new("world",1,1)

cell_test.show_cell

cell_test.shows



# Class and methods start here

# class Cell
#   attr_reader :world, :x, :y

#   def initialize(world, x, y)
#     @world = world
#     @x = x
#     @y = y
#     @live = false
#   end

#   def dead?
#     !@live
#   end

#   def dead!
#     @live = false
#   end

#   def live?
#     @live
#   end

#   def toggle!
#     @live = !@live
#   end

#   def neighbors
#     neighbors = []
#     neighbors.push(@world.cell_at(self.x-1, self.y-1))
#     neighbors.push(@world.cell_at(self.x-1, self.y))
#     neighbors.push(@world.cell_at(self.x-1, self.y+1))


#     neighbours.push(@world.cell_at(self.x, self.y - 1))
#     neighbours.push(@world.cell_at(self.x, self.y + 1))

#     neighbours.push(@world.cell_at(self.x + 1, self.y - 1))
#     neighbours.push(@world.cell_at(self.x + 1, self.y))
#     neighbours.push(@world.cell_at(self.x + 1, self.y + 1))

#     neighbors
#   end

#   def live_neighbors
#     self.neighbors.select do |n|
#       n && n.live?
#     end
#   end
# end




# test = Cell.new("world", 1, 0)

# puts test.inspect

# print test.neighborhood

# puts "\n"



