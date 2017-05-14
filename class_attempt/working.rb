
# a[row].length

#  def row_above(row, col, a)
#   return 0 if row == 0
#   if col == 0
#     a[row - 1][col] + a[row - 1][col + 1]
#   elsif col == (a[row].length -1)
#     a[row - 1][col -1] + a[row - 1][col]
#   else
#     a[row - 1][col -1] + a[row - 1][col] + a[row - 1][col + 1]
#   end
# end

#  def same_row(row, col, a)
#   if col == 0
#     a[row][col] + a[row][col + 1]
#   elsif col == (a[row].length -1)
#     a[row][col - 1] + a[row][col]
#   else
#     a[row][col -1] + a[row][col] + a[row][col + 1]
#   end
# end

#  def row_below(row, col, a)
#   return 0 if row == (a.length - 1)
#   if col == 0
#     a[row + 1][col] + a[row + 1][col + 1]
#   elsif col == (a[row].length -1)
#     a[row + 1][col -1] + a[row + 1][col]
#   else
#     a[row + 1][col - 1] + a[row + 1][col] + a[row + 1][col + 1]
#   end
# end


def add_cells(row, col)
  if col == 0
    row[col] + row[col + 1]
  elsif col == (a[row].length -1)
    row[col -1] + row[col]
  else
    row[col -1] + row[col] + row[col + 1]
  end
end

def new_row_above(row, col, a)
  return 0 if row == 0
  add_cells(a[row - 1],col)
end

def new_row_below(row, col, a)
  return 0 if row == (a.length - 1)
  add_cells(a[row + 1],col)
end

def new_same_row(row, col, a)
  add_cells(a[row], col) - a[row][col]
end


def cell_neighbors(row, col, a)
  new_row_above(row, col, a) + new_same_row(row, col, a) + new_row_below(row, col, a)
end

def next_generation(a)
  a.map.with_index do |row_of_cells, row|
    row_of_cells.map.with_index do |cell, col| # cell is already 0, 1 since it's a[row][cell]
      neighbors = cell_neighbors(a, row, col)
      if neighbors == 3
        1
      # elsif cell == 0
      #   0
      elsif (neighbors == 2)
        cell
      else
        0
      end
    end
  end
end




