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
end

if ARGV.size >= 1
  total_lines = 0
  total_words = 0
  total_bytes = 0
  ARGV.each do |file_name|
    file = File.open(file_name).read
    lines, words, bytes = calc(file)
    total_lines += lines
    total_words += words
    total_bytes += bytes
    if options['l']
      puts "#{lines.to_s.rjust(8)} #{file_name}"
    else
      output(lines, words, bytes)
      puts " #{file_name}"
    end
  end
  if options['l'] && ARGV.size > 1
    puts "#{total_lines.to_s.rjust(8)} total"
  elsif ARGV.size > 1
    puts "#{total_lines.to_s.rjust(8)}#{total_words.to_s.rjust(8)}#{total_bytes.to_s.rjust(8)} total"
  end
end
