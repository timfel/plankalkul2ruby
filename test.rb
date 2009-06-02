require 'treetop'
require 'pk2000core'
require 'pp'

p = (Treetop.load 'pk2000').new
s = ["V0[1.1:2.8.0]", "V0[i:0]", "V0[R0[:1.0]:0]",
"V0[:(1.0,0)]", "--+", "-1", "!1", "1*1", "-1+1~1",
"1=2", "-1=!2", "(1,2)=(2,3)", "1>-1",
"R815[1:0](1)", "R815[:0](1,V0[:0])",
"V0[1+1:0]", "V0[1>-1:0]",
"FIN
FIN12", "FIN12",
"[1>1
1+2*3
5]",
"w1(V0[:0]-1)[1+2
5+2]","w[5](V0[:0]-1)[1+2
5+2]",
"5+2->-1=>Z0[:0]",
"V0[:0]->(1,2)=>(Z0[:0],Z1[:0])"
]

s.each do |item|
#   pp p.parse(item)
end

s.each do |item|
   pp item unless p.parse(item)
end
