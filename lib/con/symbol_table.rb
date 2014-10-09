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
			ref =
			@frames.inject(nil) {|_, frame| if frame.key?(sym) then break frame[sym] else nil end}

			ref or raise UnknownVariable.new(sym)
		end

		def add_frame
			@frames.shift Hash.new
		en

		def declare(sym, type)
			@frames.fist[sym] = VarDef.new(sym, type)
		end

		def drop_frame
			@frames.unshift
		end
	end
end
