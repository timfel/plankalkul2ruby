class Array
   def toPKComponent
      "" if self.empty?
      self
   end
end

class String
   def toPKComponent
      self.split(".").collect {|item| item.to_i}
   end
end

class Object
   def toPKComponent
      [self.to_i]
   end
end

module Plankalkuel
   class PKTuple < Array
      def initialize arr
	 arr.each do |item|
	    self << item if item.is_a? PKVariable
	 end
      end

      def component comp, type
	 c = comp.toPKComponent
	 unless c.empty?
	    return self[c.first].component(c[1..-1].toPKComponent, type)
	 else
	    self
	 end
      end

      def <= tuple
	 raise ArgumentError,("I need a PKTuple") unless tuple.is_a? PKTuple
	 self.each_with_index do |item,i|
	    each <= tuple[i]
	 end
      end

      def dimension
	 self.size
      end
   end

   class PKVariable
      @@instances = [{}]

      def self.define array, int
	 instance(array).tap { |i| i.assignInt(int) }
      end

      def self.instance array
	 i = (instances[array.first.upcase.to_sym] || self.new(array))
	 i.component(array[1],array.last)
	 return i
      end

      def self.instances 
	@@instances.last
      end

      def self.enterScope
	 @@instances << {}
      end
      
      def self.leaveScope
	 @@instances.pop
      end

      def method_missing(meth, *args, &block)
	 self.to_i.send(meth, *args, &block)
      end

      def self.resetVariableSpace
	 @@instances = [{}]
      end

      def coerce other
	 return self, other
      end

      def initialize array
	 @name = array.first.upcase.to_sym
	 @type = array.last.toPKComponent
	 size = @type.inject(1) do |r,x| 
	    unless x == 0
	       r = r * x
	    end
	    r
	 end
	 @array = Array.new(size,0)
	 @workingBounds = 0..(@array.size-1)
	 component(array[1],array.last)
	 self.class.instances[@name.to_sym] = self
      end

      def component compString,type
	 @workingBounds = 0..(@array.size-1)
	 comp = compString.toPKComponent
	 begin
	    unless (comp.empty? || !typeSafe?(type,comp.size))
	       comp.each_with_index do |item,i|
		  raise if item+1 > @type[i]
		  sliceSize = @workingBounds.to_a.size / @type[i]
		  sliceStart = sliceSize*item.to_i+@workingBounds.to_a.first
		  @workingBounds = sliceStart...(sliceStart+sliceSize)
	       end
	    end
	 rescue Exception
	    raise ArgumentError,("The variable "+@name.to_s+" has been previously "+
				 "referenced with type "+@type.to_s+", however, "+
				 "I now got "+(comp << type).to_s)
	 end
	 self
      end

      def typeSafe? type,depth
	 unless @type[depth..-1] == type.toPKComponent
	    raise ArgumentError,("Not of same type: Expected "
				 +@type[depth..-1].to_s+", got "+type.to_s) 
	 else
	    true
	 end
      end

      def readable?
	 @name.to_s =~ /^[Z|V]/
      end

      def writeable?
	 @name.to_s =~ /^[Z|R]/
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
	 self
      end

      [:+, :-, :*, :/, :<, :>].each do |item|
	 define_method(item) do |term|
	    dimensionTest! term.dimension if term.class == self.class
	    self.to_i.send(item, term.to_i)
	 end
      end

      def == term
	 dimensionTest! term.dimension if term.class == self.class
	 (term.to_i % 2**dimension) == self.to_i 
      end

      def to_i
	 s = "0b"
	 @array[@workingBounds].reverse.each {|item| s << item.to_s}
	 Integer(s)
      end

      def assignInt int
	 # Remember: We are BigEndian with Zuse, and overflow is disregarded, only positives!
	 bitField = (int % 2**dimension).to_s(2).reverse.each_char.inject([]) do |a,c|
	    a << c
	 end
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
	    raise ArgumentError,("Not the same dimension: I am "+
				 dimension.to_s+ " and got "+
				 otherDim.to_s)
	 end
      end

      def assignPKVariable var
	 dimensionTest! var.dimension
	 assignInt var.to_i
      end
   end
end

