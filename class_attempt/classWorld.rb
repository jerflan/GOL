require "./classCell"

class World
  attr_reader :cells

  def initialize(width, height)
    @cells = []
    height.times do |x|
      @cells.push([])
      width.times do |y|
        @cells[x].push(Cell.new(self, x, y))
      end
    end
  end


  def cell_at(x, y)
    if @cells[x]
      @cells[x][y]
    end
  end

  def shows
    @cells.each do
      if @alive
        print "*"
      else
        print " "
      end
    end
  end

end



###############################
##### Program Starts Here #####
###############################

world_test = World.new(10,10)

puts "\n"

puts world_test.inspect


#world_test.shows



# class World

#   def initialize(width, height)
#     @cells = []
#     height.times do |x|
#       @cells.push([])
#       width.times do |y|
#         @cells[x].push(Cell.new(self, x, y))
#       end
#     end
#   end

#   def cells
#     @cells.flatten
#   end

#   def cell_at(x, y)
#     if @cells[x]
#       @cells[x][y]
#     end
#   end

#   def next_generation!
#     affected = []
#     cells.each do |cell|
#       if(cell.live? && cell.live_neighbors.length < 2)
#         affected.push cell
#       end
#     end
#     affected.each(&:toggle!)
#     return
#   end
# end


