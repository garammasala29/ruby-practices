# frozen_string_literal: true

require 'optparse'
require_relative 'longformat'
require_relative 'shortformat'

class Command
  def exec
    params = ARGV.getopts('alr')
    paths = search_path(dot_match: params['a'])
    format = select_formats(paths, long_format: params['l'], reverse: params['r'])
    format.output
  end

  private

  def search_path(dot_match: false)
    dot_match ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
  end

  def select_formats(paths, long_format: false, reverse: false)
    paths = paths.reverse if reverse
    long_format ? LongFormat.new(paths) : ShortFormat.new(paths)
  end
end

command = Command.new
command.exec
