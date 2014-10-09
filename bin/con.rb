#!/usr/bin/ruby

$: << File.join(File.basename(File.expand_path(__FILE__)), '../lib')

require 'readline'

require 'con/lexer'
require 'con/parser'

continue = true

while continue
	line = Readline.readline("> ", true)

	if line == 'exit'
		continue = false
	else
		puts Con::Parser.parse(Con::Lexer.lex(line)).to_s
	end
end
