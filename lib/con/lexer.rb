# Author:		Chris Wailes <chris.wailes@gmail.com>
# Project: 	Con
# Date:		2014/10/02
# Description:	This file contains a lexer for a version of Scheme.

# encoding: UTF-8

############
# Requires #
############

# Ruby Language Toolkit
require 'rltk/lexer'

#######################
# Classes and Modules #
#######################

module Con
	# The lexer for the language accepted by Con.
	class Lexer < RLTK::Lexer

		#################
		# Default State #
		#################

		rule(/\(/) { :LPAREN }
		rule(/\)/) { :RPAREN }
		rule(/:/)  { :COLON  }

#		rule(/\'/) { :QUOTE }
#		rule(/\`/) { :QUASI }
#		rule(/\./) { :DOT }

		rule(/lambda/) { :LAMBDA }
		rule(/λ/)      { :LAMBDA }

		# Types
		rule(/int/)   { :TINT   }
		rule(/float/) { :TFLOAT }

		rule(/[A-Za-z]+/) { |t| [:SYM, t.to_sym] }

		# Literals
		rule(/[0-9]+/)         { |t| [:INT,   t.to_i] }
		rule(/[0-9]+\.[0-9]+/) { |t| [:FLOAT, t.to_f] }

		# Throw away spaces and comments.
		rule(/\s/)
		rule(/;[^\n]*\n/)
	end
end
