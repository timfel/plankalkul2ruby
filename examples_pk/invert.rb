$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'pk2000runtime'

include Plankalkuel

def (Plankalkuel).p4(v0)
  PKVariable.enterScope
  PKVariable.define(["v0", "", "0"], v0.to_i)
  ((PKVariable.instance(["R0", "", "0"]) <= 0)
  if (PKVariable.instance(["V0", "", "0"]) == 0) then
    (PKVariable.instance(["R0", "", "0"]) <= 1)
  end)
  retVal = PKVariable.instance(["R0", "", "0"])
  PKVariable.leaveScope
  return retVal
end