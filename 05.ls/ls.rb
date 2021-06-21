#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

params = ARGV.getopts('alr')

def file_type(ftype)
  {
    'directory' => 'd',
    'file' => '-',
    'syembolic link' => 'l'
  }[ftype]
end

def permission(mode)
  {
    '0' => '-—-',
    '1' => '-—x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r—-',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }[mode]
end

COLUMN_NUMBER = 3

# ls -a
lists = params['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort

# ls -r
lists.reverse! if params['r']

# ls -l

if params['l']
  total = lists.sum { |list| File.stat(list).blocks }
  puts "total #{total}"
  lists.each do |list|
    file = File.stat(list)
    mode = file.mode.to_s(8)[-3..-1]
    file_mode = file_type(file.ftype) + permission(mode[0]) + permission(mode[1]) + permission(mode[2])
    link = file.nlink
    owner = Etc.getpwuid(file.uid).name
    group = Etc.getgrgid(file.gid).name
    bytes = file.size
    time = file.mtime.strftime('%_m %d %R')
    blocks = file.blocks
    puts "#{file_mode} #{link.to_s.rjust(2)} #{owner}  #{group} #{bytes.to_s.rjust(4)} #{time} #{list}"
  end
else
  column = lists.size / COLUMN_NUMBER
  column += 1 unless (lists.size % COLUMN_NUMBER).zero?
  lists << nil until (lists.size % column).zero?
  divide_lists = lists.each_slice(column).to_a.transpose
  divide_lists.each do |divide_list|
    divide_list.each do |list|
      print list.to_s.ljust(24)
    end
    print "\n"
  end
end
