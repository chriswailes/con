# Author:      Chris Wailes <chris.wailes@gmail.com>
# Project:     Con
# Date:        2014/10/06
# Description: This file contains the AST nodes for Con.

############
# Requires #
############

# Filigree
require 'filigree/abstract_class'
require 'filigree/match'

# RLTK
require 'rltk/ast'

# Con
require 'con/types'

#######################
# Classes and Modules #
#######################

module Con
	class VarDef < RLTK::ASTNode

		value :name, Symbol
		value :type, Type

		def to_s
			"#{name}:#{type}"
		end
	end

	class Expression < RLTK::ASTNode
#		extend Filigree::AbstractClass
	end

	class Lambda < Expression
		child :args, [VarDef]
		child :body, Expression

		value :type, Type

		def destructure(_)
			[@args, @body, @type]
		end

		def to_s
			if @type
				"(lambda (#{self.args.map(&:to_s).join(' ')}) #{body.to_s}):#{@type.return_type}"
			else
				"(lambda (#{self.args.map(&:to_s).join(' ')}) #{body.to_s})"
			end
		end
	end

	class NativeLambda < Lambda

	end

	class Application < Expression
		child :rator, Expression
		child :rand, [Expression]

		value :type, Type

		def destructure(_)
			[@rator, @rand, @type]
		end

		def to_s
			if @type
				"(#{rator.to_s} #{self.rand.map(&:to_s).join(' ')}):#{@type}"
			else
				"(#{rator.to_s} #{self.rand.map(&:to_s).join(' ')})"
			end
		end
	end

	class Literal < Expression

		def destructure(_)
			[@val, self.type]
		end

		def to_s
			self.val.to_s
		end
	end

	class Int < Literal
		value :val, Integer

		def type
			IntType.instance
		end
	end

	class Float < Literal
		value :val, ::Float

		def type
			FloatType.instance
		end
	end

	class VarRef < Expression
		value :def, VarDef

		def type
			@def.type
		end

		def destructure(_)
			[@def, type]
		end

		def to_s
			self.def.name.to_s
		end
	end
end
