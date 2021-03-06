# README

The purpose of this repo is to show my journey in trying to design and build the Game of Life of John Horton Conway fame in a simple ruby environment.

So far I've concluded that I need to design the game based a 2d array that houses the actions in the code.

We'll call this 2d array the "grid." As per the assignment, the size of this grid will be based on standard user input.

Within this grid, there will be an initial colony, a randomly generated 3x3 square.

Each square of the colony will have a value of either dead (0) or alive ("a")

The program assesses the value of each cell in the colony and determines whether or not the primary_cell will live into the next generation based on the following rules:
  1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
  2. Any live cell with two or three live neighbours lives on to the next generation.
  3. Any live cell with more than three live neighbours dies, as if by overpopulation.
  4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.


## Array Attempt
 ### Successes:
  1. Creating a 2d array
  2. Random assignment of a primary cell's coordinates and status
  3. Create a second 2d array of its neighbors and assign status
  4. Assess the status of each neighbor and affect primary cell status

 ### Failures:
  1. Unable to create next generation
  2. Unable to apply "colony" or neighbors method to all cells

 ### Upon Revisit:
  1. Create a second array for next generation and replace main variable.

## [Class Attempt](https://github.com/carrot-u/assignments/blob/jflan/gol/game-of-life/jflan_gol/class_attempt/jflan_gol_class.rb)
 ### Successes:
  1. Create a 2d array that randomly assigns life status to each cell
  2. Allows user to set world dimensions, initial population density, and live cell style.
  3. World respects array bounds and doesn't "wrap" as in the Matrix option.

 ### Failures:
  1. ~~Unable to apply previous colony/neighbor logic to all cells~~
  2. Unable to initiate user input as a method inside the class.

 ### Upon Revisit:
  1. Experiment with a second class to keep all methods inside the classes.
  2. Implement user options to set specific population that yield the desired patterns

## [Matrix Attempt](https://github.com/carrot-u/assignments/blob/jflan/gol/game-of-life/jflan_gol/matrix_attempt/jflan_gol_annotated.rb)
 ### Successes:
  1. Able to specify world size through standard user input
  2. Users can determine population density that triggered by a ternary operator statement

```ruby
Matrix.build(size) { rand(population) == 0 ? 1 : 0 }
```

  3. Neighbor counts are determined by "stacking" and reducing each matrix vector.
  4. Game rules truncated to 2 options:

```ruby
count == 3 || count == 4 && @board[idx / width, idx % width] == 1 ? 1 : 0
```

  5. Installed toilet to create a more graphical introduction.
  6. Employed emoji's for the world display using unicodes.
  7. Incorporated a Thread instance to allow user to stop the program without ^C.

 ### Failures:
  1. Neighbor Count does not respect array bounds and "wraps" to the opposite bound.

 ### Upon Revisit:
  1. Create the option for allowing user to input particular patterns that generate certain results
  2. Track ecah generation
  3. Allow user to select display "themes."


