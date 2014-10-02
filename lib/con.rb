# Author:		Chris Wailes <chris.wailes@gmail.com>
# Project: 	Con
# Date:		2014/10/02
# Description:	This file sets up autoloads for the RLTK module.

# The Con module contains all of the Con compiler iternals.
module RLTK
	autoload :AST,    'con/ast'
	autoload :Lexer,  'con/lexer'
	autoload :Parser, 'con/parser'
end
