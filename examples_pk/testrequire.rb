require "pathname"
$LOAD_PATH.unshift Pathname.new(__FILE__).dirname.join("../lib").expand_path.to_s
require 'pk2000'
require 'invert'

puts "\nInvertiere 0: "+Plankalkuel.p4(0).to_i.to_s
puts "Invertiere 1: "+Plankalkuel.p4(1).to_i.to_s
puts "\n...done through the power of the PK2000"

