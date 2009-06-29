class PlankalkuelLoader
  def self.load(filename, options = nil, &block)
    File.open(filename) do |file|
      parser = Pk2000Parser.new
      pkCode = file.read.
        gsub(" ", "").gsub("\n]", "]").
        gsub("[\n", "[").gsub(/^\n$/, "").
        gsub("\n\n", "\n").
        gsub("END\n", "END")
      tree = parser.parse(pkCode)
      rbCode = Ruby2Ruby.new.process(tree.toRuby)
      out = "require 'pk2000'\n"
      out << "include Plankalkuel\n"
      out << rbCode
      eval(out)
    end
  end
end
Polyglot.register("pk", PlankalkuelLoader)
