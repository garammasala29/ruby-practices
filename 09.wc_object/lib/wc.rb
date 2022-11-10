# frozen_string_literal: true

require_relative '../lib/wc_row'
require 'pathname'
require 'debug'

class Wc
  # 外から呼ぶ時と中から呼ぶ時を分け、privateメソッドを作成できるように
  def self.run(text: '', file_names: [], line_only: false)
    self.new.run(text: text, file_names: file_names, line_only: line_only)
  end

  def run(text: '', file_names: [], line_only: false) 
    wc_rows = to_wc_rows(text, file_names)
    lines = []
    line_count_sum = 0
    word_count_sum = 0
    byte_count_sum = 0
    wc_rows.each do |wc_row, file_name|
      line_count_sum += wc_row.line_count
      word_count_sum += wc_row.word_count
      byte_count_sum += wc_row.byte_count
      lines << format_row(wc_row.line_count, wc_row.word_count, wc_row.byte_count, wc_row.file_name, line_only: line_only)
    end
    if wc_rows.size > 1
      lines << format_row(line_count_sum, word_count_sum, byte_count_sum, 'total', line_only: line_only)
    end
    lines.join("\n")
  end

  private

  def to_wc_rows(text, file_names)
    if file_names.empty?
      [WcRow.new(text)]
    else
      file_names.map do |file_name|
        pathname = Pathname(file_name)
        text = pathname.read
        WcRow.new(text, file_name)
      end
    end
  end

  def format_row(line_count, word_count, byte_count, file_name, line_only: false)
    numbers = [format_number(line_count)]
    unless line_only
      numbers << format_number(word_count)
      numbers << format_number(byte_count)
    end
    "#{numbers.join} #{file_name}".rstrip
  end

  def format_number(number)
    number.to_s.rjust(8)
  end
end
