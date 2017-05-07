require 'matrix' # adds Matrix Class

class Matrix #modifies matrix class to include translate method
  def translate(row_count, col_count) # new method takes 2 arguments; row_count and col_count are the width/height arguments when creating the matrix
    Matrix[
      *row_vectors.map do |row|
        # * is a splat and indicates the number of arguments may vary
        # row_vectors returns an array of the rows of the matrix
        # vector is a single row or column in a matrix
        # row_vectors in this case is a variable to represent the collection of rows in the matrix
        # .map (alias for .collect) is like .each and results in iteration of the given block over all the elements of the matrix
        row.to_a.rotate(row_count) # WHY IS HE DOING THIS??!?!?! test without
        # convert each row to an array, and then rotate
      end.rotate(col_count) # since it's a square, this applies the same to the columns
    ]
  end
end

class Board #creates Board class
  attr_reader :width, :height #makes width and height available outside the class

  def self.random(size) # define random method on self with an argument of size
    board = Matrix.build(size) { rand(10) == 0 ? 1 : 0 }
    # define variable board as a Matrix, with the dimensions as an argument,
    # rand(10) == 0 ? 1: 0 means that 10% of the time, rand(10) will return 0
    # and if it does, set the value to 1, and if rand(10) doesn't return 0,
    # set the value to zero.
    # This ensures only 10% of the matrix cells are alive.
    new(board) # creates a new instance of the class with the matrix as the arugment.
    # board = Board.random(10)
  end

  def self.parse(board_string) # is this from the to_s method?
  #defines method parse (split into pieces) with the argument board_string
    new(Matrix[board_string.split("\n").map { |row| row.split.map(&:to_i) }])
    # splits the matrix into rows (split("\n")) then splits each row to a line of integers
  end

  def initialize(board) #instantiate a new instance of class Board with the following attributes
    @width = board.column_size # assigns @width to the attribute column_size, which is an alias for column_count
    @height = board.row_size # assigns @height to the attribute row_size, which as alias for row_count
    @board = board # assigns @board as the instance variable for the initialize argument through which we can call all these methods in the class
  end

  def next
    board_state = neighbor_counts.map.with_index do |count, idx| #defines board_state as
      count == 3 || count == 4 && @board[idx / width, idx % width] == 1 ? 1 : 0
      # set new value to 1 if count ==3 (cell is alive and 2 of its neighbors are alive OR cell is dead and 3 of its neighbors are alive)
      # OR 4 are alive and
    end

    Board.new(board_state)
  end

  def to_s # overrides to_s
    @board.row_vectors.map do |row| # map each row (row_vectors is the collection of rows)
      row.map do |n| # map each element of the row ( value not index)
        n == 1 ? "B" : "·" # if alive (1), print "B", if not print "."
      end.to_a.join(" ") #turn each row into an array and join the pieces as a single string with a space in between
    end.join("\n") # put each row on a separate line
  end

  def neighbor_counts # define method called "neighbor_counts"
    [-1,0,1].product([-1,0,1]).map do |row, col|
      #.product is an array_method that returns each combination from the object_array and the argument_array
        #  (without the block) => [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 0], [0, 1], [1, -1], [1, 0], [1, 1]] ([row, col], [row, col])
        #  creates the relative indices/positions of the neighbors [0,0] is the target cell
      @board.translate(row, col) # calls the translate method on the whole board?
    end.reduce(:+)
      #from enumerable mixin, requires each/map method
      # "reduces" all values as a sum
      # using end.sum yields an error. Is it because of the nil values when the cell is on the edge?
      # matrix.rb:1619:in `+': Operation(+) can't be defined: Integer op Matrix (ExceptionForMatrix::ErrOperationNotDefined)

      # neighbor_counts is a method on an Enumerator.
      # What the hell is an Enumerator?
        # A class which allows both internal and external iteration
        #
  end
end

if __FILE__ == $0
  # IF the file is being executed directly, i.e., as a script,
  # THEN find the directory the script is in and prepend it to beginning of the load/require search path
  b = Board.random(40) #create new board with the size argument
    # can this be standard user input?
  system("clear")
    # system is a Kernal module method
    # Kernal is a module (included in the class Object) so its methods are available to every Ruby object
    # called without a receiver?
    # system executes a bash commandline in a subshell
    # this is most likely to clear any other information that might fuck up the file
    #is this necessary? seemed to work without the clear command?


  loop do # starts the loop . . .
    puts b # puts the Board class instance
    sleep 0.2 # sleeps after it puts the instance
    system("clear") #clears the system to emulate animation
    b = b.next # runs the next generation
  end
end


####### QUESTIONS #########


# 1. What is the purpose of the parse method? Didn't see a difference
# 2. How do the neighbor_counts and translate methods work?
#       transforms (maps) each index of the matrix with a count of its neighbors
# 3. Should the intro be in the class?
# 4. How does it know to do all those things?
# 5. How to get it to stop without cntrl C

