# Author:      Chris Wailes <chris.wailes@gmail.com>
# Project:     Con
# Date:        2014/10/12
# Description: This file contains the free variable analysis for Con.

############
# Requires #
############

# Standard Library
require 'set'

# Filigree
require 'filigree/visitor'

#######################
# Classes and Modules #
#######################

module Con
	class FreeVariableAnalysis
		include Filigree::Visitor

		alias :old_init :initialize
		def initialize
			@free_set = Set.new
		end

		on Lambda.(params, _, _) do |node|
			param_syms = params.map { |p| p.def.name }

			node['free_variables'] = @free_set - param_syms

			@free_set -= param_syms
		end

		on VarRef.(vardef, _) do
			@free_set << vardef.name
		end
	end
end
