class Treetop::Runtime::SyntaxNode
   def toRuby
   end
end

class PKNumberNode < Treetop::Runtime::SyntaxNode
   def toRuby
      s(:lit, text_value.to_i)
   end
end

class PKGenericVariableNode < Treetop::Runtime::SyntaxNode
   def toRuby
      s(:call, nil, text_value.to_sym, s(:arglist))
   end
end

class PKCallNode < Treetop::Runtime::SyntaxNode
   def toRuby
      sexp = s(:call, s(:const, :Plankalkuel), 
	       ("p"+number.text_value).to_sym, argumentTuple.toRuby)
      unless comp.empty?
	 return s(:call, sexp, :component, 
		  s(:arglist, s(:str, comp.text_value), s(:str, type.text_value)))
      end
      sexp
   end
end

class PKFinNode < Treetop::Runtime::SyntaxNode
   def toRuby
      s(:break)
   end
end

class PKForNode < Treetop::Runtime::SyntaxNode
   def toRuby
      sexp = s(:iter, s(:call, forTo.toRuby, :times, s(:arglist)))
      if !count.text_value.empty?
	 i = "i"
	 i = "i"+lvl.level.toRuby if lvl.respond_to? :level
	 sexp << s(:lasgn, i.to_sym) 
      else
	 sexp << nil
      end
      sexp << block.toRuby
   end
end

class PKWhileNode < Treetop::Runtime::SyntaxNode
   def toRuby
      runI = !count.text_value.empty?
      if runI
	 i = "i"
	 i = "i"+lvl.level.toRuby if lvl.respond_to? :level
	 sexp = s(:block, s(:lasgn, i.to_sym, s(:lit, 0)))
      end
      whileSexp = s(:while, orConditionalLinesConditions)
      block = conditionalLines.toRuby
      if runI
	 block << s(:lasgn, i.to_sym, 
		    s(:call, s(:lvar, i.to_sym), 
		      :+, s(:arglist, s(:lit, 1))))
      end
      whileSexp << block
      if runI
	 return sexp << whileSexp
      end
      return whileSexp
   end

   def orConditionalLinesConditions node=conditionalLines
      if node.rest.respond_to? :next
	 s(:or, node.first.term2.toRuby, orConditionalLinesConditions(node.rest.next))
      else
	 node.first.term2.toRuby
      end
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

   def varToRuby components=nil
      components ||= text_value.split(/:|\[|\]/)
      s(:call, s(:const, :PKVariable), :instance, 
	s(:arglist, s(:array, s(:lit, components[0]), 
		     s(:lit, components[1]), s(:lit, components[2]))))
   end

   def tupleToRuby
      sexp = s(:array)
      text_value.split(",").each do |input|
	 input =~ /(.*)\[(.*):(.*)\]/
	 c = [$1, $2, $3]
	 c.collect! { |x| x.gsub(/\(|\)/, "") }
	 sexp << varToRuby(c)
      end
      s(:call, s(:const, :PKTuple), :new, s(:arglist, sexp))
   end
end

class PKBracketNode < Treetop::Runtime::SyntaxNode
   def toRuby
      s(:block , sub.toRuby)
   end
end

class PKIterativeNode < Treetop::Runtime::SyntaxNode
   def flatten_tree_on sexp
      sexp << first.toRuby
      if rest.respond_to? :next
	 rest.next.toRuby[1..-1].each do |item|
	    sexp << item
	 end
      end
      sexp
   end

   def toRuby
      sexp = s(:arglist)
      flatten_tree_on sexp
   end
end

class PKLinesNode < PKIterativeNode
   def toRuby
      sexp = s(:block)
      flatten_tree_on sexp
   end
end

class PKOperationNode < Treetop::Runtime::SyntaxNode
   @@replacers = {'=' => '=='}
   def toRuby
      operator = @@replacers[op.text_value] || op.text_value
      sexp = s(:call)
      sexp << prefix.text_value if respond_to? :prefix
      sexp << prefixedTerm.toRuby << operator.to_sym << condition.toRuby
      sexp
   end
end

class PKMethodNode < Treetop::Runtime::SyntaxNode
   def toRuby
      sexp = s(:defs, s(:const, :Plankalkuel), ("p"+number.text_value).to_sym)
      sexp << randauszug.vTuple.toRuby
      block = s(:block)
      block << s(:call, s(:const, :PKVariable), :enterScope, s(:arglist))
      arguments = randauszug.vTuple.text_value.gsub(/\(|\)|\[[^V]*\]/, "").downcase
      arguments.split(",").each do |item|
	 block << s(:call, s(:const, :PKVariable), 
		    :define, s(:arglist, s(:array, s(:str, item), s(:str, ""), s(:str, "32.0")), 
			      s(:lvar, item.to_sym)))
      end
      block << lines.toRuby
      block << s(:lasgn, :retVal, randauszug.rTuple.toRuby)
      block << s(:call, s(:const, :PKVariable), :leaveScope, s(:arglist))
      block << s(:return, s(:lvar, :retVal))
      sexp << s(:scope, block)
   end
end
