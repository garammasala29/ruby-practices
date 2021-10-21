# frozen_string_literal: true

class ShortFormat
  COL_COUNT = 3

  def initialize(paths)
    @paths = paths
  end

  def output
    max_filename_count = @paths.map(&:size).max
    row_count = (@paths.size.to_f / COL_COUNT).ceil
    transposed_filenames = safe_transpose(@paths.each_slice(row_count).to_a)
    puts format_table(transposed_filenames, max_filename_count)
  end

  private

  def safe_transpose(nested_filenames)
    nested_filenames[0].zip(*nested_filenames[1..])
  end

  def format_table(filenames, max_filename_count)
    filenames.map do |row_files|
      # 「7」はfile間の空白の数
      row_files.map { |filename| filename.to_s.ljust(max_filename_count + 7) }.join.rstrip
    end
  end
end
