#!/usr/bin/ruby

#
# move active window around
#


require 'rubygems'
require 'trollop'

opts = Trollop::options do
  version "v0.0.1a"
  opt :left, "Move active window to the left"
  opt :right, "Move active window to the left"
end

cmd = "xprop -root -f _NET_ACTIVE_WINDOW 0x \" \\$0\\\\n\" _NET_ACTIVE_WINDOW | awk \"{print \\$2}\""
currentWindowID = `#{cmd}`
currentWindowID.chomp!
s = currentWindowID.slice(-7,7)

cmd = "wmctrl -lG | grep #{s}"
geometry = `#{cmd}`
#puts geometry
a = geometry.split(/\s+/)

id = a[0]
x = a[2]
y = a[3]
w = a[4]
h = a[5]

#puts "x:#{x} y:#{y} w:#{w} h:#{h}"

x = x.to_i

if opts.left
  r = x % 960

  x -= r
  x -= 960
  if x < 0
    x = 0
  end
  cmd = "wmctrl -i -r #{id} -e '0,#{x},0,960,#{h}'"
  #puts cmd
  `#{cmd}`
elsif opts.right
  r = x % 960
  x -= r
  x += 960
  if x > 2880
    x = 2880
  end
  cmd = "wmctrl -i -r #{id} -e '0,#{x},0,960,#{h}'"
  #puts cmd
  `#{cmd}`
end