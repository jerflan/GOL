grid = [
  [0,0,0,0,0],      #[0] = row #1
  [0,0,0,0,0],     #[1] = row #2
  [0,0,0,0,0], #[2] = row #3
  [0,0,0,0,0], #[3] = row #4
  [0,0,0,0,0]  #[4] = row #5
]

puts "Grid:"
grid.each do |x|
  print "#{x}\n"
end

puts "-" * 40

grid[0][0] = "a" # defining which cells are alive
grid[1][1] = "a"

colony = [grid[0][0..2],grid[1][0..2], grid[2][0..2]]
puts "Colony:"
colony.each do |x|
  print "#{x}\n"
end

puts "-" * 40

primary_cell = grid[1][1]
puts "Primary Cell: = grid[1][1]"

puts "-" * 40

puts "How many cells in the colony are alive?"

def alive_count(colony)
  alive = 0
  colony.each_index do  |x| # assessing the value of each cell
    colony[x].each_index do |y|
      if colony[x][y] == "a"
        puts "[#{x}][#{y}] == #{colony[x][y]} is true"
        alive += 1
      else
        puts false
      end
    end
  end
puts "Number of Alive Cells: #{alive}"
end

alive_count(colony)
puts alive

puts "-" * 40



puts "-" * 40

grid.each_index do |x|
  if x < 3
    grid[x].each_index do |y|
      if y < 3
        puts grid[x][y] #calls the value of the coordinate in the colony
      else
        break
      end
    end
  else
    break
  end
end


# ma = [
#   [1,2,3,4,5],      #[0] = row #1
#   [6,7,8,9,10],     #[1] = row #2
#   [11,12,13,14,15], #[2] = row #3
#   [16,17,18,19,20], #[3] = row #4
#   [21,22,23,24,25]  #[4] = row #5
# ]

# multi_array.each do |x|
#   print "#{x}\n"
# end

# print multi_array[0]
# puts "\n"
# print multi_array[0][2]
# puts "\n"







# number_array = [[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16]]
# string_array = [["Apple", "Banana"], ["Carrot", "Daikon"]]

# # puts number_array #each array item has its own line
# # puts string_array

# # puts number_array[2] # prints [9,10,11,12]
# # puts number_array[2][1] * 5 # prints the second item of the third array * 5
# # puts string_array[1][1][3] #prints the k in Daikon 3rd letter of 2nd item in 2nd array
# string_array.each do |x|
#   x.each do |y|
#     puts y[2]
#   end
# end


# grid = {} # Hash.new

# grid[1] = [1,2,3,4,5]

# puts grid.inspect









# class SparseArray
#   attr_reader :hash

#   def initialize
#     @hash = {}
#   end

#   def [](key)
#     hash[key] ||= {}
#   end

#   def rows
#     hash.length
#   end

#   alias_method :length, :rows
# end

# sparse_array = SparseArray.new
# sparse_array[1][2] = 3
# sparse_array[1][2] #=> 3

# p sparse_array.hash
# #=> {1=>{2=>3}}

# #
# # dimensions
# #
# sparse_array.length    #=> 1
# sparse_array.rows      #=> 1

# sparse_array[0].length #=> 0
# sparse_array[1].length #=> 1
