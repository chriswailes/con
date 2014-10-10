#!/usr/bin/ruby

$: << File.join(File.basename(File.expand_path(__FILE__)), '../lib')

require 'readline'

require 'con/lexer'
require 'con/parser'

continue = true

while continue
	line = Readline.readline("Con > ", true)


	if not line or line == 'exit'
		puts
		continue = false
	else
		begin
			puts Con::Parser.parse(Con::Lexer.lex(line)).to_s

		rescue RLTK::NotInLanguage => e
			puts 'Invalid input'

		rescue Con::UnknownVariable => e
			puts e.message
		end
	end
end
