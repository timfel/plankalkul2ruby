require "parse_tree"
require "ruby2ruby"

module SexpStuff

  def r2r(a, b = nil)
    return Ruby2Ruby.new.process(a) if a.is_a? Sexp
    r2r u(a, b = nil)
  end

  def u(a, b = nil)
    unless @unifier
      @unifier = Unifier.new
      @unifier.processors.each { |p| p.unsupported.delete :cfunc }
    end
    case a
    when Sexp then sexp = a
    when String, Class then sexp = ParseTree.translate(a, b)
    when Proc then sexp = ParseTree.new.parse_tree_for_proc(a)
    else raise ArgumentError, "dunno how to handle #{a.inspect}"
    end
    @unifier.process sexp
  end

end

include SexpStuff
