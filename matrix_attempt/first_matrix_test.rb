require 'Matrix' #adds Matrix Class

class Matrix
  def translate(row_count, col_count)
    Matrix[
      *row_vectors.map do |row|
        row.to_a.rotate(row_count)
      end.rotate(col_count)
    ]
  end
end

class Board
  attr_reader :width, :height #allows outside of class

  def initialize(board)
    @board = board
    @width = board.column_count
    @height = board.row_count
  end

  def self.create
    print "How big do you want the world to be? "
    size = gets.chomp.to_i
    print "How much space do you want between residents on a scale of 1 to 10? "
    population = gets.chomp.to_i
    puts "Ready to play God in"
    5.downto(1) do |n|
      puts "#{n}..."
      sleep(1)
    end
    puts "Let there be LYFE!"
    system("clear")
    board = Matrix.build(size) { rand(population) == 0 ? 1 : 0 }
    new(board)
  end

  # def self.parse(board_string)
  #   new(Matrix[board_string.split("\n").map { |row| row.split.map(&:to_i) }])
  # end

  def neighbor_counts
    [-1,0,1].product([-1,0,1]).map do |row, col|
    @board.translate(row, col)
    end.reduce(:+)
  end

  def to_s #implied with puts board
    @board.row_vectors.map do |row|
      row.map do |n|
        n == 1 ? "\u{2728}" : "\u{2B1B}"
      end.to_a.join(" ")
    end.join("\n")
  end

  def next
    board_state = neighbor_counts.map.with_index do |count, idx|
      count == 3 || count == 4 && @board[idx / width, idx % width] == 1 ? 1 : 0
    end
    Board.new(board_state)
  end
end

########## PROGRAM ##########

# print "How big do you want the world to be? "
# size = gets.chomp.to_i
# print "How much space do you want between residents on a scale of 1 to 10? "
# population = gets.chomp.to_i

# puts "Ready to play God in"
# 5.downto(1) do |n|
#     puts "#{n}..."
#     sleep(1)
#   end
# puts "Let there be LYFE!"
# system("clear")

# b = Board.create(size, population)

# puts b.inspect
# puts b.neighbor_counts

b = Board.create

loop do
  puts "-" * @width.to_i
  puts b
  puts "-" * @width.to_i
  sleep 0.1
  system("clear")
  b = b.next
end
