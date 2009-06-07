$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'pk2000core'

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
      eachNil? ["R0815[1:0](1)"], false
      eachNil? ["R815[:0](1,V0[:0])"], false
      eachNil? ["R3[0:4.0](Z1[:8.0],Z3[:8.0])"], false
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
      eachNil? ["P815(V0[:8.0])=>(R0[:8.0])\nFIN\nEND",
         "P815(V0[:8.0])=>R0[:8.0]\nFIN\nEND"], false
      eachNil? ["P0815(V0[:8.0])=>(R0[:8.0])\nFIN\nEND", 
	 "P815(V0[:8.0])=>(R0[:8.0])\nFIN", "P0815\nFIN\nEND", ], true
   end
end
