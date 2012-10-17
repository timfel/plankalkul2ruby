$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'pk2000runtime'

include Plankalkuel

def (Plankalkuel).p6(v0)
  PKVariable.enterScope
  PKVariable.define(["v0", "", "32.0"], v0.to_i)
  ((PKVariable.instance(["Z0", "", "32.0"]) <= PKVariable.instance(["V0", "", "32.0"]))
  (PKVariable.instance(["R0", "", "32.0"]) <= Plankalkuel.p5(Plankalkuel.p5(PKVariable.instance(["Z0", "", "32.0"])))))
  retVal = PKVariable.instance(["R0", "", "32.0"])
  PKVariable.leaveScope
  return retVal
end