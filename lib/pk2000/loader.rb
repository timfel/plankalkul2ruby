class PlankalkuelLoader
   def self.load(filename, options = nil, &block)
      File.open(filename) do |file|
	 parser = Pk2000Parser.new
	 #puts file.read
	 pkCode = file.read.
	    gsub(" ", "").gsub("\n]", "]").
	    gsub("[\n", "[").gsub(/^\n$/, "").
	    gsub("END\n", "END")
	 tree = parser.parse(pkCode)
	 rbCode = Ruby2Ruby.new.process(tree.toRuby)
	 out = "require 'pk2000'\n"
	 out << "include Plankalkuel\n"
	 out << rbCode
	 puts out
	 eval(out)
      end
   end
end
Polyglot.register("pk", PlankalkuelLoader)
