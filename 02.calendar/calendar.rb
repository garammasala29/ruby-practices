require 'date'
require 'optparse'

options = ARGV.getopts('y:', 'm:')
year = options["y"].to_i
mon  = options["m"].to_i

year = Date.today.year if year == 0
mon = Date.today.mon if mon == 0

first_day_wday = Date.new(year, mon, 1).wday
last_day = Date.new(year, mon, -1)
wdays = ["日", "月", "火", "水", "木", "金", "土"]

title = "#{mon}月  #{year}"
puts title.to_s.center(20)
puts wdays.join(" ")
print "   " * first_day_wday

(1..last_day.day).each do |day|
  print day.to_s.rjust(2) + " "
  day_wday = Date.new(year, mon, day)
  print "\n" if day_wday.wday == 6
end
puts "\n"

