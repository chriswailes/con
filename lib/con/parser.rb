# Author:		Chris Wailes <chris.wailes@gmail.com>
# Project: 	Con
# Date:		2014/10/02
# Description:	This file contains a parser for a version of Scheme.

############
# Requires #
############

# Ruby Language Toolkit
require 'rltk/parser'

# Con
require 'con/symbol_table'

#######################
# Classes and Modules #
#######################

module Con
	# A parser for the language accepted by Con.
	class Parser < RLTK::Parser

		p(:e) do
			c('SYM')   { |n| @st[n] }
			c('INT')   { |n| Con::Int.new(n) }
			c('FLOAT') { |n| Con::Float.new(n) }

			c('LPAREN LAMBDA LPAREN .params RPAREN .e RPAREN') { |params, body| @st.drop_frame; Lambda.new(nil, params, body) }

			c('LPAREN .e .e* RPAREN') { |rator, rands| Application.new(nil, rator, rands) }
		end

		p(:params) do
			c('')                { [] }
			c(:params_prime) { |lst| lst }
		end

		p(:params_prime) do
			c('.SYM COLON .type')               { |s, t|           [@st.declare(s, t)] }
			c('.params_prime .SYM COLON .type') { |lst, s, t| lst << @st.declare(s, t) }
		end

		p(:type) do
			c(:TINT)   { |_| :int   }
			c(:TFLOAT) { |_| :float }
		end

		token_hook(:LAMBDA) {@st.add_frame}

		class Environment < Environment
			def initialize
				@errors = Array.new
				@st     = SymbolTable.new
			end
		end

		finalize explain: 'con.automata'
	end
end
