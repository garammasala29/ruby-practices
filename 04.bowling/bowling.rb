# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0

frames.each_with_index do |frame, i|
  point += if i <= 8
             if frame[0] == 10 && frames[i + 1][0] == 10
               frames[i + 2][0] + 20
             elsif frame[0] == 10
               frames[i + 1].sum + 10
             elsif frame.sum == 10
               frames[i + 1][0] + 10
             else
               frame.sum
             end
           else
             frame.sum
           end
end
puts point
