$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'pk2000core'
require 'ruby2ruby'

describe PKVariable do 
   before do 
      PKVariable.resetVariableSpace
   end

   it "is only readable if it is input value" do
      PKVariable.instance(["V0", "", "8.0"]).readable?.should_not.nil?
      PKVariable.instance(["V0", "", "8.0"]).writeable?.should.nil?
   end

   it "is only writeable if it is return value" do
      PKVariable.instance(["R0", "", "8.0"]).writeable?.should_not.nil?
      PKVariable.instance(["R0", "", "8.0"]).readable?.should.nil?
   end

   it "is R/W if it is local variable" do
      PKVariable.instance(["Z0", "", "8.0"]).readable?.should_not.nil?
      PKVariable.instance(["Z0", "", "8.0"]).writeable?.should_not.nil?
   end

   it "is combinable only with same-dimension variables" do
      v8_1 = PKVariable.instance(["Z0", "", "8.0"])
      v8_2 = PKVariable.instance(["Z1", "", "8.0"])
      v4_1 = PKVariable.instance(["Z2", "", "4.0"])
      (v8_1 + v8_2).should == 0
      proc { (v8_1 + v4_1) }.should raise_error
   end

   it "is always combinable with constants" do
      v4_1 = PKVariable.instance(["Z2", "", "4.0"])
      (v4_1 + 2).should == 2
      v4_1 <= v4_1 + 2
      (v4_1 - 1).should == 1
      (v4_1 * 2).should == 4
      (v4_1 / 2).should == 1
      # einmal für negative zuweisung
      v4_1 <= -1
      (v4_1 == -1).should == true
      # einmal für zuweisung im wertebereich
      v4_1 <= 4
      (v4_1 == 4).should == true
      # einmal für zuweisung oberhalb des wertebereiches
      v4_1 <= 128
      (v4_1 == 128).should == true
   end

   it "selects always the same variable with the same selector" do
      z1 = PKVariable.instance(["Z0", "", "8.0"])
      z2 = PKVariable.instance(["z0", "", "8.0"])
      (z1.equal? z2).should == true
      z2 = PKVariable.instance(["Z0", "0", "0"])
      (z1.equal? z2).should == true
   end

   it "can be selected only type-safely" do
      v = PKVariable.instance(["Z0", "", "4.2.0"])
      PKVariable.instance(["Z0", "1", "2.0"]).should_not.nil?
      proc { PKVariable.instance(["Z0", "1", "4.2.0"]) }.should raise_error(ArgumentError)
   end
end

describe "Parser" do
   before do
      @parser = Pk2000Parser.new
   end

   def eachNil? array, flag
      array.each do |item|
	 puts '-- FAILED: "'+item+'"' unless @parser.parse(item).nil? == flag
	 @parser.parse(item).nil?.should == flag
      end
   end

   it "parses all kinds of different variables - but only valid ones!" do
      eachNil? ["V0[1.1:2.8.0]", "R0[i:0]", "V0[R0[:1.0]:0]", "Z1[2:2.0]", "V0[:(1.0,0)]", 
      	"V0[1+1:0]", "V0[1>-1:0]"], false
      eachNil? ["Q0[1:0]", "V0[:1]"], true
   end

   it "parses logical constants" do
      eachNil? ["+", "-", "++", "--", "+-+", "--+"], false
   end

   it "understands prefix ! and -" do
      eachNil? ["!1", "-0", "-i", "!i", "!V0[:0]", "!R3[:3.0]"], false
      eachNil? ["+1", "*1"], true
   end

   it "can read operations" do
      eachNil? ["-1+2", "1+1", "2*1", "1+2+3", "V0[:8.0]/2", "15-V0[:8.0]", "i*Z0[:32.0]"], false
      eachNil? ["1++2", "2**1"], true
   end

   it "can understand conditions" do
      eachNil? ["1=2", "-1=!2", "(1,2)=(2,3)", "V0[:8.0]>-1"], false
      eachNil? ["1!=2", "1==2", "<2", ">1"], true
   end

   it "calls forward other functions" do
      eachNil? ["R0815[1:0](1)", "R815[:0](1,V0[:0])", "R3[0:4.0](Z1[:8.0],Z3[:8.0])"], false
      eachNil? ["R01(1)"], true
   end

   it "puts blocks into context" do
      eachNil? ["[5+5\n2+7]", "[4->5]"], false
      eachNil? ["[]", "[5+5", "5+5]"], true
   end

   it "breaks multi-level cycles" do
      eachNil? ["FIN", "FIN1", "FIN12"], false
      eachNil? ["FIN-1", "FIN0"], true
   end

   it "loops endlessly whenever I call" do
      eachNil? ["w1(V0[:0]-1)[1=1->1+2]", "w[1->3+4]", "w1(5)[5>2->5+6]", "W1[0->7+8]"], false
      eachNil? ["w2[3+4]", "w[3+4]"], true
   end

   it "can understand tuples" do
      # tuples in pk2000 are not terms in their own right, they can only be used as types and 
      # in assignments or conditions
      eachNil? ["(Z0[:2.0],Z1[:2.0])=(1,2)", "(Z0[:2.0],5)=(1,2)", "Z0[:(8.0,6.0)]"], false
   end

   it "assigns me all the data I desire" do
      eachNil? ["V0[:0]=>Z0[:0]", "3=>R0[:2.0]", "-1=>Z0[:0]", "(V0[:0],V1[:0])=>(Z0[0:0],Z0[1:0])"], false
      eachNil? ["3=>1"], true
   end

   it "can have brackets around each statement, term+prefix or lines" do
      eachNil? ["(5)", "(-5)", "(5+2->1=>R0[:0])", "(5*1)+2", "(5*1)+2=>R0[:0]"], false
      eachNil? ["(5->1)=>Z0[:2.0]"], true
   end 

   it "unconditionally conditionalizes all implications" do
      eachNil? ["5+2->1=>R0[:0]", "1->5", "V0[:0]->(Z0[:0],Z1[:0])=>(Z1[:0],Z0[:0])"], false
      eachNil? ["!->5", "FIN->5"], true
   end

   it "can request dimensions of a given variable" do
      eachNil? ["N(V0[:2.0])", "N(Z1[0:1.0])+1"], false
      eachNil? ["N(1)"], true
   end

   it "approves of methods, if it sees it's function" do
      eachNil? ["P815(V0[:8.0])=>(R0[:8.0])\nFIN\nEND"], false
      eachNil? ["P0815(V0[:8.0])=>(R0[:8.0])\nFIN\nEND", 
	 "P815(V0[:8.0])=>(R0[:8.0])\nFIN", "P0815\nFIN\nEND", ], true
   end
end

describe "Compiler" do
   before do
      @parser = Pk2000Parser.new
      PKVariable.resetVariableSpace
   end

   def r2r(string)
      sexp = @parser.parse(string).toRuby
      sexp.should.class == Sexp
      code = Ruby2Ruby.new.process(sexp)
      code.should.class == String 
      sexp = @parser.parse(string).toRuby
      [code, sexp]
   end

   def compile(string, equal=nil)
      unless equal
	 return r2r(string)[1]
      end
      code = r2r(string)[0]
      eval(code).should.class == equal unless equal.nil?
      eval(code)
   end

   it "compiles numbers" do
      compile("6", Fixnum).should == 6
      compile("0", Fixnum).should == 0
      compile("10", Fixnum).should == 10
   end

   it "compiles prefixes" do
      compile("!1", FalseClass)
      compile("-1", Fixnum).should == -1
   end

   it "compiles generic variables" do
      compile("i1")[2].should == :i1
      compile("i")[2].should == :i
   end

   it "compiles logic constants" do
      pending
      compile("+", Array)
      compile("-", Array)
      compile("--+", Array)
   end

   it "compiles variables" do
      compile("Z0[:0]", PKVariable)
      compile("Z1[:(8.0,2.0)]", PKVariable)
      compile("Z2[:8.0]", PKVariable)
      compile("Z2[0:0]", PKVariable)
      compile("(Z2[0:0], Z3[:2.0])", PKTuple)
   end

   it "compiles operations" do
      compile("1+0", Fixnum).should == 1
      compile("5-5", Fixnum).should == 0
      compile("5/5", Fixnum).should == 1
      compile("5*5", Fixnum).should == 25
      compile("5|5", Fixnum)
      compile("5~5", Fixnum)
   end

   it "compiles conditions" do
      compile("1=1", TrueClass)
      compile("2<1", FalseClass)
      compile("2>1", TrueClass)
      compile("(Z0[:2.0],Z1[:3.0])=(1,2)", FalseClass)
   end

   it "compiles the count macro" do
      compile("N(Z0[:2.0])", Fixnum).should == 2
      compile("N(Z1[:(2.0,3.0)])", Fixnum).should == 2
   end

   it "compiles function-calls" do
      pending
      compile("R0815[1:0](1)")[0].should == :call
      compile("R0815[1:0](1)")[1].should == :PK0815
   end

   it "compiles FIN statements" do
      compile("FIN")[0].should == :break
      compile("FIN2")[0].should == :break
   end

   it "compiles blocks" do
      compile("[5+2]", Fixnum).should == 7
      compile("[5+2\n8+2]", Fixnum).should == 10
   end

   it "compiles conditionals" do
      compile("1->5", Fixnum)
      compile("1->5")[0].should == :if
   end

   it "compiles loops" do
      pending
      compile("w[1->3+4]")
      compile("w1(5)[5>4->5+1]")
      compile("w1[5>4->5+1]")
   end

   it "compiles assignments" do
      compile("2=>Z0[:2.0]", PKVariable).to_i.should == 2
   end

   it "compiles functions" do
      compile("P815(V0[:8.0])=>(R0[:8.0])\nFIN\nEND")[0].should == :defs
      compile("P815(V0[:8.0])=>(R0[:8.0])\nFIN\nEND")[1][1].should == :Plankalkuel
      compile("P815(V0[:8.0])=>(R0[:8.0])\nFIN\nEND")[2].should == :p815
      compile("P815(V0[:8.0])=>(R0[:8.0])\nFIN\nEND")[3][1].should == :v0
      compile("P815(V0[:8.0])=>(R0[:8.0])\nFIN\nEND")[4][0] == :scope
   end
end
