# frozen_string_literal: true
require 'pathname'
require 'debug'

class Wc
  def self.run(text: '', file_names: [], line_only: false)
    texts = []
    if file_names.empty?
      texts << [text, '']
    else
      file_names.each do |file_name|
        pathname = Pathname(file_name)
        text = pathname.read
        texts << [text, file_name]
      end
    end
    lines = []
    line_count_sum = 0
    word_count_sum = 0
    byte_count_sum = 0
    texts.each do |text, file_name|
      line_count = text.lines.count
      word_count = text.split.size
      byte_count = text.size
      line_count_sum += line_count
      word_count_sum += word_count
      byte_count_sum += byte_count
      line = if line_only
               "#{line_count.to_s.rjust(8)} #{file_name}".rstrip
             else
               "#{line_count.to_s.rjust(8)}#{word_count.to_s.rjust(8)}#{byte_count.to_s.rjust(8)} #{file_name}".rstrip
             end
      lines << line
    end
    if texts.size > 1
      line = if line_only
               "#{line_count_sum.to_s.rjust(8)} total"
             else
               "#{line_count_sum.to_s.rjust(8)}#{word_count_sum.to_s.rjust(8)}#{byte_count_sum.to_s.rjust(8)} total"
             end
      lines << line
    end
    lines.join("\n")
  end
end
