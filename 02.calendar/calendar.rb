# frozen_string_literal: true

require 'date'
require 'optparse'
require 'paint'

options = ARGV.getopts('y:', 'm:')
today = Date.today
year = options['y']&.to_i || today.year
month  = options['m']&.to_i || today.month

first_day_wday = Date.new(year, month, 1).wday
last_day = Date.new(year, month, -1)
wdays = %w[日 月 火 水 木 金 土]

title = "#{month}月  #{year}"
puts title.to_s.center(20)
puts wdays.join(' ')
print '   ' * first_day_wday

(1..last_day.day).each do |day|
  date = Date.new(year, month, day)
  if date == today
    print "#{Paint[day.to_s.rjust(2), :inverse]} "
  else
    print "#{day.to_s.rjust(2)} "
  end
  print "\n" if date.saturday?
end
puts "\n"
