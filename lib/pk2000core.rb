require 'treetop'
require 'pk2000'

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
	       ("p"+number.text_value).to_sym, s(:arglist, argumentTuple.toRuby)
      if respond_to? :component && not component.text_value.nil?
	 return s(:call, sexp, :component, s(:arglist, component.text_value, type.text_value))
      else
	 return sexp
      end
   end
end

class PKFinNode < Treetop::Runtime::SyntaxNode
   def toRuby
      s(:break)
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

class PKIterativeNode < Treetop::Runtime::SyntaxNode
end

class PKLinesNode < Treetop::Runtime::SyntaxNode
   def toRuby
      sexp = s(:block)
      sexp << first.toRuby
      unless rest.empty?
	 rest.next.toRuby[1..-1].each do |item|
	    sexp << item
	 end
      end
      sexp
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
