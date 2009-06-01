require 'treetop'

Treetop.load "pk"
parser = PkParser.new

testcode = "P0815  Simpletest  (V0[:8.0])  =>  (R0[:8.0])
4  => Z0[:2.2.0]
V0[:8.0] + 1 => R0[:8.0]
END"

