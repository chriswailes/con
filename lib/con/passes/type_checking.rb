# Author:      Chris Wailes <chris.wailes@gmail.com>
# Project:     Con
# Date:        2014/10/10
# Description: This file contains the type checking pass for Con.

############
# Requires #
############

# Filigree
require 'filigree/visitor'

#######################
# Classes and Modules #
#######################

module Con
	class TypeError < Exception

	end

	class TypeChecking
		include Filigree::Visitor

		on VarDef.(_, type).as node do
			type
		end

		on Lambda.(params, body, _).as node do
			param_types = params.map { |p| visit p }

			node.type = FunctionType.new(param_types, (visit node.body))
		end

		on Application.(rator, rands, _).as node do
			rator_type = visit rator
			rands_type = rands.map { |e| visit e }

			if rator_type.param_types != rands_type
				raise TypeError, "Type mismatch in application."
			end

			node.type = rator_type.return_type
		end

		on Literal.(_, type) do
			type
		end

		on VarRef.(_, type) do
			type
		end
	end
end
