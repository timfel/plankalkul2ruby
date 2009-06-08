require 'spec_helper' 

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
      compile("i1")[1][2].should == :i1
      compile("i")[1][2].should == :i
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
      compile("R0815[:0](1)")[1][0].should == :call
      compile("R0815[:0](1)")[1][2].should == :p0815
      compile("R0815[1:0](1)")[1][1][2].should == :p0815
   end

   it "compiles FIN statements" do
      compile("FIN")[1][0].should == :break
      compile("FIN2")[1][0].should == :break
   end

   it "compiles blocks" do
      compile("[5+2]", Fixnum).should == 7
      compile("[5+2\n8+2]", Fixnum).should == 10
   end

   it "compiles bracketed statements" do
      pending
   end

   it "compiles ifThens" do
      compile("1->5", Fixnum)
      compile("1->5")[1][0].should == :if
      compile("1->[1+2\n5]", Fixnum)
      compile("1->[1+2\n5]")[1][0].should == :if
   end

   it "compiles loops" do
      compile("w1(5)[5>4->5+1]")[1][0].should == :iter
      compile("w1(5)[55+1]")[1][2][1].should == :i
      compile("w(5)[55+1]")[1][1][2].should == :times
      compile("w[1->3+4]")[1][0].should == :while
      compile("w[1->3+4]")[1][1][1].should == 1
      compile("w1[1->3+4]")[1][1].should == s(:lasgn, :i, s(:lit, 0))
      compile("w1[1->3+4]")[1][2][0].should == :while
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
