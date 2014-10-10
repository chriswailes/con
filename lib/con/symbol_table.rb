# Author:      Chris Wailes <chris.wailes@gmail.com>
# Project:     Con
# Date:        2014/10/06
# Description: This file contains the AST nodes for Con.

############
# Requires #
############

require 'con/ast'

#######################
# Classes and Modules #
#######################

module Con
	class UnknownVariable < Exception
		def initialize(sym)
			super "Unknown variable: #{sym}"
		end
	end

	class SymbolTable
		def initialize
			# Initialize our frames with the global frame.
			@frames = [{}]
		end

		def [](sym)
			symdef =
			@frames.inject(nil) {|_, frame| if frame.key?(sym) then break frame[sym] else nil end}

			if symdef then VarRef.new(symdef) else raise UnknownVariable.new(sym) end
		end

		def add_frame
			@frames.unshift(Hash.new)
		end

		def declare(sym, type)
			if @frames.first[sym]
				raise "Attempting to add symbol #{sym} to the same frame a second time."
			end

			@frames.first[sym] = VarDef.new(sym, type)
		end

		def drop_frame
			@frames.shift
		end
	end
end
