require 'pk2000'
require 'select'
require 'setupColor'
require 'setup'
require 'move'
require 'king'
require 'queen'
require 'rook'
require 'bishop'
require 'knight'
require 'pawn'

puts Plankalkuel.p11(1).to_i
puts Plankalkuel.p11(0).to_i
field=Plankalkuel.p1(0)
puts Plankalkuel.p2(1,1,field,0).to_i
