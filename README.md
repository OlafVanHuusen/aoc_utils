# AocUtils

A small Ruby gem with utility functions for solving [Advent of Code](https://adventofcode.com/) problems. It focuses on the two things you do every day of AoC: turning a puzzle input file into usable Ruby data structures, and navigating grid/maze inputs.

Everything lives in the top-level `AocUtils` module, with maze helpers grouped under `AocUtils::MazeUtils`.

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

## API

### `AocUtils` — parsing a whole input file

These methods read an entire file and return one entry per line.

#### `AocUtils.read_ints(filename, other_characters = [])`

Reads a file and returns the integers on each line (negatives included) as one array per line.

As a side effect it appends, into the optional `other_characters` array, the first character of each line that is not a digit or whitespace — note this includes a leading `-`, so a line beginning with a negative number records `"-"`, and a line with no such character records `nil`.

```ruby
File.write("input.txt", "1 2 3\n4 5 6\n")

AocUtils.read_ints("input.txt")
# => [[1, 2, 3], [4, 5, 6]]

# Capturing the first non-digit character of each line:
markers = []
AocUtils.read_ints("input.txt", markers)
# markers now holds one entry per line (nil when a line is only digits/spaces)
```

#### `AocUtils.read_strings(filename)`

Reads a file and returns, for each line, the comma-separated fields with surrounding whitespace stripped.

```ruby
File.write("input.txt", "apple, banana, cherry\ndog, cat\n")

AocUtils.read_strings("input.txt")
# => [["apple", "banana", "cherry"], ["dog", "cat"]]
```

#### `AocUtils.read_chars(filename)`

Reads a file and returns each line as an array of its individual characters (line stripped first).

```ruby
File.write("input.txt", "ABC\nDEF\n")

AocUtils.read_chars("input.txt")
# => [["A", "B", "C"], ["D", "E", "F"]]
```

### `AocUtils` — parsing a two-section input file

#### `AocUtils.read_two_parts(filename, datatype1, datatype2)`

Splits a file at its first blank line into two sections and parses each section independently using one of the type names `"Integer"`, `"String"`, or `"Char"`.

Per-type parsing of a section:

- `"Integer"` → each line becomes an array of the integers it contains: `Array<Array<Integer>>`.
- `"String"` → each line is split on commas and stripped, then **all lines are flattened** into a single `Array<String>`.
- `"Char"` → each line becomes an array of its characters: `Array<Array<String>>`.

```ruby
File.write("input.txt", "1 2 3\n4 5 6\n\napple, banana\ncherry, date\n")

part1, part2 = AocUtils.read_two_parts("input.txt", "Integer", "String")
# part1 => [[1, 2, 3], [4, 5, 6]]
# part2 => ["apple", "banana", "cherry", "date"]   # note: flattened
```

Notes on behaviour (verified against the source):

- The file **must** contain a blank line; it is the separator between the two sections. Without one, the method raises.
- An invalid `datatype1` raises `"Invalid datatype"`. An invalid `datatype2` does **not** raise — that section is returned as its raw stripped lines (`Array<String>`). This asymmetry is a quirk of the current implementation.

### `AocUtils::MazeUtils` — navigating a 2D grid

A grid is a 2D array of single-character strings (row-major, indexed as `maze[y][x]`). By convention `'#'` is a wall and `'.'` is open space, matching the output of `AocUtils.read_chars`.

#### `AocUtils::MazeUtils.find_char(maze) { |cell| ... }`

Returns the `[x, y]` coordinates of the first cell (scanning row by row) for which the block returns true.

```ruby
maze = [['#', '.', 'S'],
        ['.', '#', '.'],
        ['E', '.', '#']]

AocUtils::MazeUtils.find_char(maze) { |cell| cell == 'S' }
# => [2, 0]

AocUtils::MazeUtils.find_char(maze) { |cell| cell == 'E' }
# => [0, 2]
```

When no cell matches, the method returns the `maze` array itself (the return value of the underlying `each_with_index`), **not** `nil`. Test for a match with an explicit comparison rather than relying on a falsey return.

#### `AocUtils::MazeUtils.calculate_distance_to_point(maze, point)`

Fills a maze in place with the breadth-first (shortest-path) distance from `point` (`[x, y]`) to every reachable open cell.

The starting cell is set to `0` and every reachable `'.'` cell is overwritten with its integer distance. Every other wall (`'#'`) is left untouched — **but the starting cell is always overwritten with `0`, even when it is a wall**, because the method writes it unconditionally before the search begins. The method mutates `maze` and returns `nil`.

In the example below the starting point `[1, 1]` is the center wall, and it becomes `0` in the result.

```ruby
maze = [['.', '.', '.'],
        ['.', '#', '.'],
        ['.', '.', '.']]

AocUtils::MazeUtils.calculate_distance_to_point(maze, [1, 1])
# maze is now:
# [[2, 1, 2],
#  [1, 0, 1],
#  [2, 1, 2]]
```

## License

This gem is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Bug reports and pull requests are welcome.

## Author

Lennard Clicque (l.clicque@gmail.com)
