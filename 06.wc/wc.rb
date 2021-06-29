#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('l')

def calc(contents)
  lines = contents.count("\n")
  words = contents.split(/\s+/).count
  bytes = contents.bytes.count
  [lines, words, bytes]
end

def output(lines, words, bytes)
  print lines.to_s.rjust(8)
  print words.to_s.rjust(8)
  print bytes.to_s.rjust(8)
end

if ARGV.empty?
  input = $stdin.read
  lines, words, bytes = calc(input)
  if options['l']
    print lines.to_s.rjust(8)
  else
    output(lines, words, bytes)
  end
  puts
else
  total =
    ARGV.inject({ lines: 0, words: 0, bytes: 0 }) do |result, file_name|
      file = File.open(file_name).read
      lines, words, bytes = calc(file)
      if options['l']
        puts "#{lines.to_s.rjust(8)} #{file_name}"
      else
        output(lines, words, bytes)
        puts " #{file_name}"
      end
      result[:lines] += lines
      result[:words] += words
      result[:bytes] += bytes
      result
    end
  if ARGV.size > 1
    if options['l']
      puts "#{total[:lines].to_s.rjust(8)} total"
    else
      puts "#{total[:lines].to_s.rjust(8)}#{total[:words].to_s.rjust(8)}#{total[:bytes].to_s.rjust(8)} total"
    end
  end
end
