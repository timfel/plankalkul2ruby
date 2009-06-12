require 'spec_helper' 

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
      v4_1.to_i.should == 4
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

   it "selects the proper component even nested" do
      v = PKVariable.instance(["Z0", "", "2.16.3.0"])
      PKVariable.instance(["Z0", "1", "16.3.0"]).
	 instance_eval("@workingBounds").to_a.first.should == 48
      PKVariable.instance(["Z0", "1.15", "3.0"]).
	 instance_eval("@workingBounds").to_a.first.should == 93
   end
end

