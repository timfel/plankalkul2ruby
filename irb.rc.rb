PKPROGRAM = "P815(V0[:8.0],V1[:2.0])=>(R0[:8.0])
FIN
END"

require 'sexp_stuff'
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "lib")
require 'pk2000core'
PARSER  = Pk2000Parser.new
TESTPROG = "15=>Z0[:4.0]
1=>Z1[:4.0]"
TREE = PARSER.parse(PKPROGRAM)
