PROGRAM = "P815 (V0[:8.0])=>(R0[:8.0])
FIN
V0[:8.0]=2->4+1=>Z0[:2.2.0]
w1(V0[:0]-1)[1+2]
w[3+4]
w1(5)[5+6]
w1[7+8]
END"

require 'sexp_stuff'
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "lib")
require 'pk2000core'
PARSER  = Pk2000Parser.new
TESTPROG = "15=>Z0[:4.0]
1=>Z1[:4.0]"
TREE = PARSER.parse(PROGRAM)
