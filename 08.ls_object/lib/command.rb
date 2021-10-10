# frozen_string_literal: true

require 'optparse'
require_relative 'longformat'
require_relative 'shortformat'

class Command
  def initialize
    params = ARGV.getopts('alr')
    paths = search_path(dot_match: params['a'])
    sort_paths = sort_paths(paths, reverse: params['r'])
    @format = select_formats(sort_paths, long_format: params['l'])
  end

  def exec
    @format.output
  end

  private

  def search_path(dot_match: false)
    dot_match ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
  end

  def sort_paths(paths, reverse: false)
    reverse ? paths.sort.reverse : paths.sort
  end

  def select_formats(paths, long_format: false)
    long_format ? LongFormat.new(paths) : ShortFormat.new(paths)
  end
end

command = Command.new
command.exec
