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

		on Lambda.(params, body, _) do |node|
			node.type = FunctionType.new((params.map &:type), (body.type))
		end

		on Application.(rator, rands, _) do |node|
			rator_type = rator.type
			rands_type = rands.map &:type

			if rator_type.param_types != rands_type
				raise TypeError, "Type mismatch in application."
			end

			node.type = rator_type.return_type
		end
	end
end
