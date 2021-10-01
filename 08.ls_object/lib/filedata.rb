# frozen_string_literal: true

require 'etc'

MODE_TABLE = {
  '0' => '---',
  '1' => '-x-',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

class FileData
  def initialize(path)
    @path = path
  end

  def build_stat
    fs = File.stat(@path)
    {
      path: @path,
      type_and_mode: format_type_and_mode(fs),
      nlink: fs.nlink,
      user: Etc.getpwuid(fs.uid).name,
      group: Etc.getgrgid(fs.gid).name,
      bytesize: fs.size,
      mtime: fs.mtime.strftime('%_m %d %R'),
      blocks: fs.blocks
    }
  end

  private

  def format_type_and_mode(file_stat)
    type = file_stat.directory? ? 'd' : '-'
    digits = file_stat.mode.to_s(8).slice(-3..-1).chars
    mode = digits.map { |n| MODE_TABLE[n] }.join
    type + mode
  end
end
