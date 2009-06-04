require 'treetop'
require 'pk2000'

class PKVariable
   @@instances = {}

   def self.define array, int
      instance(array).tap { |i| i.assignInt(int) }
   end

   def self.instance array
      i = (@@instances[array.first.upcase.to_sym] || self.new(array))
      i.component(array[1],array.last)
      return i
   end

   def method_missing(meth, *args, &block)
      self.to_i.send(meth, *args, &block)
   end

   def self.resetVariableSpace
      @@instances = {}
   end

   def coerce other
      return self, other
   end

   def initialize array
      @name = array.first.upcase.to_sym
      @type = strToComp(array.last)
      size = @type.inject(1) do |r,x| 
	 unless x == 0
	    r = r * x
	 end
	 r
      end
      @array = Array.new(size,0)
      @workingBounds = 0..(@array.size-1)
      self.component(array[1],array.last)
      @@instances[@name.to_sym] = self
   end

   def strToComp str
      str.split(".").collect {|item| item.to_i}
   end

   def component compString,type
      @workingBounds = 0..(@array.size-1)
      comp = strToComp compString
      begin
	 unless (comp.empty? ||	!typeSafe?(type,comp.size))
	    comp.each_with_index do |item,i|
	       raise if item > @type[i]
	       sliceSize = @workingBounds.to_a.size / @type[i]
	       sliceStart = sliceSize*item.to_i
	       @workingBounds = sliceStart...(sliceStart+sliceSize)
	    end
	 end
      rescue Exception
	 raise ArgumentError,("The variable "+@name+" has been previously referenced with type "+@type.to_s+", however, I now got "+compString)
      end
   end

   def typeSafe? type,depth
      unless @type[depth..-1] == strToComp(type)
	 raise ArgumentError,("Not of same type: Expected "+@type[depth..-1].to_s+", got "+type) 
      else
	 true
      end
   end

   def readable?
      @name =~ /^[Z|V]/
   end

   def writeable?
      @name =~ /^[Z|R]/
   end

   def value
      if readable?
	 @array[@workingBounds]
      else
	 raise ArgumentError,"I am a RESULT-Variable, I should never be read!" 
      end
   end

   def <=(term)
      if writeable?
	 if term.is_a? Integer 
	    self.assignInt(term)
	 elsif term.class == self.class 
	    self.assignPKVariable(term)
	 end
      else
	 raise ArgumentError,"I am an INPUT-VARIABLE, I should never be written to!"
      end
   end

   [:+, :-, :*, :/, :<, :>, :~].each do |item|
      define_method(item) do |term|
	 dimensionTest! term.dimension if term.class == self.class
	 self.to_i.send(item, term.to_i % dimension ** 2)
      end
   end

   def == term
      dimensionTest! term.dimension if term.class == self.class
      (term.to_i % dimension ** 2) == self.to_i 
   end

   def to_i
      s = "0b"
      @array[@workingBounds].reverse.each {|item| s << item.to_s}
      Integer(s)
   end

   def assignInt int
      # Remember: We are BigEndian with Zuse, and overflow is disregarded, only positives!
      bitField = (int % dimension**2).to_s(2).reverse
      @workingBounds.to_a.each_with_index do |item,i|
	 @array[item] = bitField[i].to_i
      end
   end

   def dimension
      @workingBounds.to_a.size
   end

   def dimensionTest! otherDim
      # only variables with the same dimension may be combined
      if dimension != otherDim
	 raise ArgumentError,("Not the same dimension: I am "+dimension.to_s+ " and got "+otherDim.to_s)
      end
   end

   def assignPKVariable var
      dimensionTest! var.dimension
      assignInt var.to_i
   end
end

class Treetop::Runtime::SyntaxNode
   def toRuby
      text_value
   end

   def toC
      text_value
   end
end

class PKCallNode < Treetop::Runtime::SyntaxNode
   def toRuby
      "break"
   end
end

class PKFinNode < Treetop::Runtime::SyntaxNode
   def toRuby
      "break"
   end
end

class PKWhileNode < Treetop::Runtime::SyntaxNode
   def forToGet
      return fixed.forTo if fixed.respond_to? :forTo
      return nil
   end
   def toRubyFor
      s = "("+forToGet.toRuby+").times do " 
      s << " |i|" if count
      s << " \n ("
   end
   def toRubyWhile
      s = "i = 0\nflag=true\n" if count.text_value == "1"
      s = "flag=true\n" if s.nil?
      s << " while(flag) do flag = (\n"
   end
   def toRuby
      if forToGet
	 s = toRubyFor
      else
	 s = toRubyWhile
      end
      s << "Proc.new "+block.toRuby+".call"
      s << "\n) \nend"
   end
end

class PKVariableNode < Treetop::Runtime::SyntaxNode
   def toRuby
      if text_value =~ /^\(.*\)$/
	 return tupleToRuby
      else
	 return varToRuby
      end
   end

   def varToRuby
      components = text_value.split(/:|\[|\]/)
      "PKVariable.instance("+components.to_s+")"
   end

   def tupleToRuby
      s = ""
      text_value.split(",").each do |input| 	 
	 input =~ /(.*)\[(.*):(.*)\]/
	 a = [$1, $2, $3]
	 a.collect! { |x| x.gsub(/\(|\)/, "") }
	 s << ("PKVariable.instance("+a.to_s+")")
	 s << "," unless input == text_value.split(",").last
      end
      s
   end
end

class PKIterativeNode < Treetop::Runtime::SyntaxNode
   def toRuby
      s = first.toRuby+"\n"
      s << rest.next.toRuby unless rest.empty?
      s
   end
end

class PKOperationNode < Treetop::Runtime::SyntaxNode
   @@replacers = {'=' => '==', '~' => '.equal?'}
   def toRuby
      operator = @@replacers[op.text_value] || op.text_value
      s = " ("
      s << prefix.text_value if respond_to? :prefix
      s << prefixedTerm.toRuby << operator << condition.toRuby << ") "
   end
end

class PKMethodNode < Treetop::Runtime::SyntaxNode
   def toRuby
      s = "def PK"+number.text_value+"("+randauszug.vTuple.toRuby+")\n"
      randauszug.vTuple.toRuby.split(",").each do |item|
	 s << "PKVariable.define(['"+item+"', '', '32.0'], "+item+")\n"
      end
      s << "\n" << lines.toRuby
      s << "\nreturn "+randauszug.rTuple.toRuby << "\nend"
      s
   end
end
