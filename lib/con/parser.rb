# Author:		Chris Wailes <chris.wailes@gmail.com>
# Project: 	Con
# Date:		2014/10/02
# Description:	This file contains a parser for a version of Scheme.

############
# Requires #
############

# Ruby Language Toolkit
require 'rltk/parser'

#######################
# Classes and Modules #
#######################

module Con
		# A parser for the language accepted by Con.
		class Parser < RLTK::Parser
			
			p(:e) do
				c('SYM') {}
				c('INT') { |n| n }
				c('FLOAT') {}
				
				clause('LPAREN e RPAREN') { |_, e, _| e }
			end
			
			finalize
		end
	end
end
