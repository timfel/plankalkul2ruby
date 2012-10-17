$LOAD_PATH.unshift(File.expand_path("../../../lib", __FILE__))
require 'pk2000'
require 'logic/setupColor'  # single Color setup, p11(0/1)
require 'logic/setup'   # complete setup, p1(0)
require 'logic/select'    # is_selectable_by_you? p2(0/1)
require 'logic/move'    # is_movable_there? p2(0/1)
require 'logic/king'    # king move
require 'logic/queen'   # queen move
require 'logic/rook'    # rook move
require 'logic/bishop'    # bishop move
require 'logic/knight'    # knight move
require 'logic/pawn'    # pawn move
#require 'logic/delete'   # deleting stones

class PKChess
  include Plankalkuel

  def initialize
    @field = Plankalkuel.p1(0)
  end

  def select x,y,color
    Plankalkuel.p2(x,y,@field,color).to_i > 0
  end

  def move x1,y1,x2,y2,color
    field = Plankalkuel.p3(x1,y1,x2,y2,@field,color)
    if field > 0
      @field = field
    end
    field > 0
  end

  def delete x,y,color
    field = Plankalkuel.p37(x,y,@field,color)
    @field = field if field > 0
    field > 0
  end
end
