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

  # -rw-r--r--  1 m.kawamura  staff  0  9 25 19:54 123456789
  def build_stat
    fs = File.stat(@path)
    {
      path: @path,
      type: format_type(fs),
      mode: format_mode(fs.mode),
      nlink: fs.nlink,
      username: Etc.getpwuid(fs.uid).name,
      grpname: Etc.getgrgid(fs.gid).name,
      bytesize: fs.size,
      mtime: fs.mtime.strftime('%_m %d %R'),
      blocks: fs.blocks
    }
  end

  def format_type(file_stat)
    file_stat.directory? ? 'd' : '-'
  end

  def format_mode(mode)
    # fs.modeを8進数にしたときの右三桁がパーミッションを表しているので取り出す
    permissions = mode.to_s(8).slice(-3..-1).chars
    # 三桁の数字をrwx文字表記に変換
    permissions.map { |n| MODE_TABLE[n] }.join
  end
end

path = Dir.glob('*').first
data = FileData.new(path)
p data.build_stat
