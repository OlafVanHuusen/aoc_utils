# AocUtils

A Ruby gem providing utility functions for solving [Advent of Code](https://adventofcode.com/) problems. This gem simplifies common tasks like reading and parsing input files, working with different data types, and navigating mazes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aoc_utils'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install aoc_utils
```

## Usage

```ruby
require 'aoc_utils'
```

## Documentation

### File Reading Methods

#### `AocUtils.read_ints(filename, other_characters = [])`

Extracts all integers from a file, including negative numbers.

**Parameters:**
- `filename` (String): The name of the file to read from
- `other_characters` (Array<String>, optional): An array that will be populated with the first non-integer character found in each line

**Returns:**
- `Array<Array<Integer>>`: A 2D array where each element represents a line from the file, containing all integers found on that line

**Example:**
```ruby
# File content: "1 2 3\n4 5 6"
ints = AocUtils.read_ints("input.txt")
# => [[1, 2, 3], [4, 5, 6]]

# With other_characters
other_chars = []
ints = AocUtils.read_ints("input.txt", other_chars)
```

---

#### `AocUtils.read_strings(filename)`

Extracts all strings from a file, splitting by commas and removing whitespace.

**Parameters:**
- `filename` (String): The name of the file to read from

**Returns:**
- `Array<String>`: A 2D array where each element represents a line from the file, split by commas with whitespace trimmed

**Example:**
```ruby
# File content: "apple, banana, cherry\ndog, cat"
strings = AocUtils.read_strings("input.txt")
# => [["apple", "banana", "cherry"], ["dog", "cat"]]
```

---

#### `AocUtils.read_chars(filename)`

Extracts all characters from a file as a 2D array.

**Parameters:**
- `filename` (String): The name of the file to read from

**Returns:**
- `Array<Array<String>>`: A 2D array where each element represents a line, with each line split into individual characters (whitespace trimmed)

**Example:**
```ruby
# File content: "ABC\nDEF"
chars = AocUtils.read_chars("input.txt")
# => [["A", "B", "C"], ["D", "E", "F"]]
```

---

#### `AocUtils.read_two_parts(filename, datatype1, datatype2)`

Reads a file that contains two sections separated by an empty line, parsing each section according to specified data types.

**Parameters:**
- `filename` (String): The name of the file to read from
- `datatype1` (String): The datatype for the first section. Options: `"Integer"`, `"String"`, or `"Char"`
- `datatype2` (String): The datatype for the second section. Options: `"Integer"`, `"String"`, or `"Char"`

**Returns:**
- `Array<Array>`: An array containing two arrays - the first section parsed as `datatype1` and the second section parsed as `datatype2`

**Example:**
```ruby
# File content:
# "1 2 3
# 4 5 6
# 
# apple, banana
# cherry, date"

part1, part2 = AocUtils.read_two_parts("input.txt", "Integer", "String")
# part1 => [[1, 2, 3], [4, 5, 6]]
# part2 => ["apple", "banana", "cherry", "date"]
```

---

### MazeUtils Class

A utility class for working with 2D maze structures, where `'#'` represents walls and `'.'` represents empty spaces.

#### `AocUtils::MazeUtils.find_char(maze) { |cell| block }`

Finds the coordinates of a character in the maze that matches the given block condition.

**Parameters:**
- `maze` (Array<Array<String>>): A 2D array representing the maze
- `block`: A block that takes a cell character and returns true when the desired cell is found

**Returns:**
- `Array<Integer>`: The `[x, y]` coordinates of the first matching cell, or `nil` if not found

**Example:**
```ruby
maze = [['#', '.', 'S'], ['.', '#', '.'], ['E', '.', '#']]
start_pos = AocUtils::MazeUtils.find_char(maze) { |cell| cell == 'S' }
# => [2, 0]

end_pos = AocUtils::MazeUtils.find_char(maze) { |cell| cell == 'E' }
# => [0, 2]
```

---

#### `AocUtils::MazeUtils.calculate_distance_to_point(maze, point)`

Calculates the shortest distance from a given point to all reachable cells in the maze using breadth-first search (BFS). This method modifies the maze in place, replacing `'.'` characters with their distance from the starting point.

**Parameters:**
- `maze` (Array<Array>): A 2D array representing the maze (will be modified in place)
- `point` (Array<Integer>): The starting point as `[x, y]` coordinates

**Returns:**
- `nil` (the maze is modified in place)

**Example:**
```ruby
maze = [['.', '.', '.'], ['.', '#', '.'], ['.', '.', '.']]
AocUtils::MazeUtils.calculate_distance_to_point(maze, [1, 1])
# maze is now modified with distances from point [1, 1]:
# [[2, 1, 2], [1, 0, 1], [2, 1, 2]]
```

---

## License

This gem is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Bug reports and pull requests are welcome.

## Author

Lennard Clicque (l.clicque@gmail.com)

