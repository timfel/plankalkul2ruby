require "pathname"
$LOAD_PATH.unshift Pathname.new(__FILE__).dirname.join("../lib").expand_path.to_s
require 'pk2000'
require 'invert'
require 'timesplus5'
require 'factorial'

puts "\nInvertiere 0: "+Plankalkuel.p4(0).to_i.to_s
puts "Invertiere 1: "+Plankalkuel.p4(1).to_i.to_s

puts "\nAddiere 4x 5: "+Plankalkuel.p1(4).to_i.to_s
puts "Addiere 2x 5: "+Plankalkuel.p1(2).to_i.to_s

puts "\nFakultat 4: "+Plankalkuel.p5(4).to_i.to_s
puts "Fakultat 2: "+Plankalkuel.p5(2).to_i.to_s

puts "\n...done through the power of the PK2000"

