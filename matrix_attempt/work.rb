  def neighbor_counts
    [-1,0,1].product([-1,0,1]).map do |row, col|
    @board.translate(row, col)
    end.reduce(:+)
  end

  def translate(row_count, col_count)
    Matrix[
      *row_vectors.map do |row|
        row.to_a.rotate(row_count)
      end.rotate(col_count)
    ]
  end

  def next
    board_state = neighbor_counts.map.with_index do |count, idx|
      count == 3 || count == 4 && @board[idx / width, idx % width] == 1 ? 1 : 0
    end
    Board.new(board_state)
  end

  ######################

 # create a new array for the next generation
