require 'pk2000'
require 'logic/setupColor' 	# single Color setup, p11(0/1)
require 'logic/setup'		# complete setup, p1(0)
require 'logic/select'	# is_selectable_by_you? p2(0/1)

class PKChess
   include Plankalkuel

   def initialize
      @field = Plankalkuel.p1(0)
   end

   def select x,y
      Plankalkuel.p2(x,y,@field,0).to_i > 0
   end

   def move x1,y1,x2,y2
      true
   end
end
