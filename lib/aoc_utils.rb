# Desc: Utility functions for Advent of Code problems
module AocUtils
  # extracts all integers from the specified file
  # @param filename [String] the name of the file to read from
  # @param other_characters [Array<String>] will save the first non integer character in the line for further usage
  # @return [Array<Array<Integer>>] an array of all the lines read from the file, with each line being an array of the integers read from that line
  def self.read_ints(filename, other_characters = [])
    ints = []
    File.open(filename).each_line do |line|
      ints << line.scan(/-?\d+/).map(&:to_i)
      other_characters << line[/[^0-9\s]/]
    end
    ints
  end

  # extracts all strings from the specified file
  # @param filename [String] the name of the file to read from
  # @return [Array<String>] an array of all the lines read from the file as strings with no leading or trailing whitespace
  def self.read_strings(filename)
    strings = []
    File.open(filename).each_line do |line|
      strings << line.strip
    end
    strings
  end

  # extracts all characters from the specified file
  # @param filename [String] the name of the file to read from
  # @return [Array<Array<String>>] an array of all the lines read from the file, with each line being an array of the characters read from that line with no leading or trailing whitespace
  def self.read_chars(filename)
    chars = []
    File.open(filename).each_line do |line|
      chars << line.strip.chars
    end
    chars
  end

  # extracts all lines from the specified file and splits them into two parts based on an empty line
  # @param filename [String] the name of the file to read from
  # @param datatype1 [String] the datatype of the first part of the file, either "Integer", "String", or "Char"
  # @param datatype2 [String] the datatype of the second part of the file, either "Integer", "String", or "Char"
  # @return [Array<Array>] an array containing two arrays, the first being the first part of the file and the second being the second part of the file
  def self.read_two_parts(filename, datatype1, datatype2)
    lines = File.open(filename).readlines.map(&:strip)
    index = lines.index("")
    part1 = lines[0...index]
    part2 = lines[(index + 1)..-1]
    case datatype1
    when "Integer"
      part1 = part1.map { |line| line.scan(/-?\d+/).map(&:to_i) }
    when "String"
      part1 = part1.map(&:strip)
    when "Char"
      part1 = part1.map(&:strip.chars)
    else
      raise "Invalid datatype"
    end
    case datatype2
    when "Integer"
      part2 = part2.map { |line| line.scan(/-?\d+/).map(&:to_i) }
    when "String"
      part2 = part2.map(&:strip)
    when "Char"
      part2 = part2.map(&:chars)
    end
    [part1, part2]
  end
end
