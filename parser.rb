class PK
   def self.regex
      Regexp.compile(/.*/)
   end

   def initialize string
      if match(string)
	 parse string
      else
	 raise "Match error! "+self.class.to_s+" -> "+string
      end
   end
   
   def match string
      string =~ self.class.regex
   end

   def parse string
      raise "Should have been overwritten!"
   end
   
   def to_ruby
      raise "Should have been overwritten!"
   end
end

class PKProgram < PK
   def self.regex
      Regexp.new(/(P[0-9]+) (\(.*\)) => (\(.*\))(.*)END/m)
   end

   def parse string
      string =~ self.class.regex
      @methodName = $1
      @inTerm = VTuple.new $2
      @outTerm = RTuple.new $3
      @block = PKBlock.new $4
   end
   
   def to_ruby
      puts "def "+@methodName+@inTerm.to_ruby
      puts "\t"+@block.to_ruby
      puts "\treturn "+@outTerm.to_ruby
      puts "end"
   end
end

class PKAssign < PK
   def self.regex
      /((.*)=>(.*))/
   end
end

class PKCond < PK
   def self.regex
      /(.*)->(.*)/
   end
end

class PKWhile < PK
   def self.regex
      # $1 - counted?, $2 - nested?, $3 - from-to?, $4 - block
      /[w|W]([0-9]?)(\[[0-9]+\])?(\(.*\))? (\[.*\])/m
   end
end

class PKStatement < PK
   def self.regex
      Regexp.union(PKAssign.regex, PKCond.regex, PKWhile.regex, /FIN[0-9]*/)
   end

   def parse string
   end

   def to_ruby 
      ""
   end
end

class PKBlock < PK
   def self.regex
      /[a-z]* \[[^\]]*\]|[^\n]*/m
   end

   def parse string
      @lines = []
      split = string.scan(self.class.regex).reject {|x| x == ""}
      puts split
      split.each do |item|
	 @lines << PKStatement.new(item)
      end
   end

   def to_ruby
      s = ""
      @lines.each do |item|
	 s << item.to_ruby+"\n"
      end
      s
   end

end

class Tuple < PK
   def self.regex
      /\([A-Z][0-9]+\[.*\](,[A-Z][0-9]+\[.*\])*\)/
   end

   def parse string
      @variables = []
      (string.split(/,|\(|\)/).reject {|x| x == ""}).each do |item|
	 @variables << (Variable.new item)
      end
   end
   
   def to_ruby
      s = "("
      @variables.each do |item|
	 s << item.to_ruby << ", "
      end
      s << ")"
      s
   end
end

class VTuple < Tuple
   def self.regex 
      /^([^A-Z]|V)*$/
   end

   def match string
      super(string) && string =~ self.class.regex
   end
end

class RTuple < Tuple
   def self.regex
      /^([^A-Z]|R)*$/
   end

   def match string
      super(string) && string =~ self.class.regex
   end
end

class Variable < PK
   def variable string
      @writeable = true unless (string =~ /^V.*/)
      @readable = true unless (string =~ /^R.*/)
      @variable = string
   end

   def parse string
      match = (string =~ /([V|Z|R][0-9]+)\[([0-9]+)?:([0-9]+(\.[0-9]+)*\])/)
      variable $1
      @component = $2
      @type = $3
      match
   end

   def to_ruby
      s = "{"+@variable
      s << "["+@component+"]" if @component
      s << "(Typ:"+@type+", "
      s << "Readable" if @readable
      s << "Writable" if @writeable
      s << "}"
      s
   end
end

s = "P0815 (V0[:2.0]) => (R0[:2.0])\n0 => Z0\nV0[:2.0] -> + => R0[0]\nw1 (5) [ \ni => R0]\nEND"
puts s
p = PKProgram.new(s)
p.to_ruby
