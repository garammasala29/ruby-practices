# frozen_string_literal: true

# 1行当たりの必要なデータ
class WcRow
  attr_reader :file_name

  def initialize(text, file_name = '')
    @text = text
    @file_name = file_name
  end

  def line_count
    @text.lines.count
  end

  def word_count
    @text.split.size
  end

  def byte_count
    @text.size
  end
end
