# Author:      Chris Wailes <chris.wailes@gmail.com>
# Project:     Con
# Date:        2014/10/06
# Description: This file contains the AST nodes for Con.

############
# Requires #
############

# Filigree
require 'filigree/abstract_class'

# RLTK
require 'rltk/ast'

#######################
# Classes and Modules #
#######################

module Con
	class VarDef < RLTK::ASTNode
		value :name, Symbol
		value :type, Symbol

		def to_s
			"#{name}:#{type}"
		end
	end

	class Expression < RLTK::ASTNode
#		extend Filigree::AbstractClass

#		abstract_method :type
	end

	class Lambda < Expression
		child :args, [VarDef]
		child :body, Expression

		def to_s
			"(lambda (#{self.args.map(&:to_s).join(' ')}) #{body.to_s})"
		end
	end

	class NativeLambda < Lambda

	end

	class Application < Expression
		child :rator, Expression
		child :rand, [Expression]

		def to_s
			"(#{rator.to_s} #{self.rand.map(&:to_s).join(' ')})"
		end
	end

	class Literal < Expression
		def to_s
			self.val.to_s
		end
	end

	class Int < Literal
		value :val, Integer
	end

	class Float < Literal
		value :val, Float
	end

	class VarRef < Expression
		value :def, VarDef

		def to_s
			self.def.name.to_s
		end
	end
end
