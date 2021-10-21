# frozen_string_literal: true

require 'etc'
require_relative 'filestat'

class LongFormat
  def initialize(paths)
    @file_stats = paths.map { |path| FileStat.new(path).build_stat }
  end

  def output
    block_total = @file_stats.sum { |stat| stat[:blocks] }
    puts "total #{block_total}"
    @file_stats.each do |stat|
      puts long_format(stat, max_size_map)
    end
  end

  private

  def max_size_map
    {
      nlink: @file_stats.map { |stat| stat[:nlink].to_s.size }.max,
      user: @file_stats.map { |stat| stat[:user].size }.max,
      group: @file_stats.map { |stat| stat[:group].size }.max,
      bytesize: @file_stats.map { |stat| stat[:bytesize].to_s.size }.max
    }
  end

  def long_format(stat, max_size_map)
    [
      stat[:type_and_mode],
      " #{stat[:nlink].to_s.rjust(max_size_map[:nlink])}",
      stat[:user].ljust(max_size_map[:user]),
      " #{stat[:group].ljust(max_size_map[:group])}",
      " #{stat[:bytesize].to_s.rjust(max_size_map[:bytesize])}",
      stat[:mtime],
      stat[:path]
    ].join(' ')
  end
end
