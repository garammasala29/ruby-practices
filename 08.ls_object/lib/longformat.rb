# frozen_string_literal: true

require 'etc'
require_relative 'filestat'

class LongFormat
  def initialize(paths)
    @paths = paths.map { |path| FileStat.new(path) }
  end

  def output
    path_stats = @paths.map(&:build_stat)
    block_total = path_stats.sum { |stat| stat[:blocks] }
    puts "total #{block_total}"
    max_size_map = build_max_size_map(path_stats)
    path_stats.each do |stat|
      puts long_format(stat, max_size_map)
    end
  end

  private

  def build_max_size_map(path_stats)
    {
      nlink: path_stats.map { |stat| stat[:nlink].to_s.size }.max,
      user: path_stats.map { |stat| stat[:user].size }.max,
      group: path_stats.map { |stat| stat[:group].size }.max,
      bytesize: path_stats.map { |stat| stat[:bytesize].to_s.size }.max
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
