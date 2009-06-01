require 'treetop'
require 'pp'

p = (Treetop.load 'pk2000').new
s = ["V0[1.1:0]", "V0[i:0]", "V0[R0[:1.0]:0]",
"V0[:(1.0,0)]", "--", "-1", "!1", "1*1", "-1+1~1",
"1=2", "-1=!2"]

s.each do |item|
   pp item unless p.parse(item)
end

