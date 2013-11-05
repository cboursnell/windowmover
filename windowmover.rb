#!/usr/bin/ruby

#
# move active window around
#

# wmctrl -r :ACTIVE: -b remove,maximized_vert; wmctrl -r :ACTIVE: -b remove,maximized_horz; wmctrl -r :ACTIVE: -e 0,0,0,674,768
require 'rubygems'
require 'trollop'

opts = Trollop::options do
  version "v0.0.1a"
  opt :left, "Move active window to the left"
  opt :right, "Move active window to the left"
  opt :fullheight, "Increase height to full"
  opt :test, "Don't actually do anything"
end

cmd = "xprop -root -f _NET_ACTIVE_WINDOW 0x \" \\$0\\\\n\" _NET_ACTIVE_WINDOW | awk \"{print \\$2}\""
currentWindowID = `#{cmd}`
currentWindowID.chomp!
puts "currentWindowID: #{currentWindowID}" if opts.test
s = currentWindowID.slice(-7,7)

cmd = "wmctrl -lG | grep #{s}"
geometry = `#{cmd}`
puts geometry if opts.test

if geometry=~/desktop/ or geometry=~/Desktop/
  puts "this is an invalid window" if opts.test
  exit
end

a = geometry.split(/\s+/)

id = a[0]
x = a[2]
y = a[3]
w = a[4]
h = a[5]

puts "x:#{x} y:#{y} w:#{w} h:#{h}" if opts.test

x = x.to_i

if opts.left
  x-=4
  r = x % 960
  x -= r
  if x <1920
    h=1138
  else
    h=1173
  end
  if x<0
    x=0
  end
  cmd = "wmctrl -i -r #{id} -e '0,#{x},0,954,#{h}'"
  puts cmd if opts.test
  `#{cmd}` if !opts.test
elsif opts.right
  r = x % 960
  x -= r
  x += 960
  if x <1920
    h=1138
  else
    h=1173
  end
  if x > 2880
    x = 2880
  end
  cmd = "wmctrl -i -r #{id} -e '0,#{x},0,960,#{h}'"
  puts cmd if opts.test
  `#{cmd}` if !opts.test
elsif opts.fullheight
  if x <1920
    h=1138
  else
    h=1173
  end
  cmd = "wmctrl -i -r #{id} -e '0,#{x},0,#{w},#{h}'"
  puts cmd if opts.test
  `#{cmd}` if !opts.test
end
