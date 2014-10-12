#!/usr/bin/env ruby

$: << File.join(File.basename(File.expand_path(__FILE__)), '../lib')

require 'readline'

require 'con/lexer'
require 'con/parser'
require 'con/passes/type_checking'
require 'con/version'

require 'filigree/configuration'
require 'filigree/match'

class Configuration
	include Filigree::Configuration

	usage "./con.rb [options]"

	add_option Filigree::Configuration::HELP_OPTION

	attr_reader :mode

	def set_mode(mode)
		if not @mode.nil?
			raise 'Only one mode may be used.'
		end
		@mode = mode
	end

	help 'Dump lexer output and exit.'
	option 'tokenize' do
		set_mode :lex
	end

	help 'Dump AST and exit.'
	option 'dumpast' do
		set_mode :parse
	end

	help 'Launch the REPL.'
	option 'repl' do
		set_mode :repl
	end

	help 'File to process.'
	string_option 'file', 'f'

	# TODO: Add an option to evaluate an expression given on the command line (-e).
end

def file_contents_or_stdin(file)
	if file then File.open(file).read else STDIN.read end
end

def tokenize(conf)
	puts Con::Lexer.lex(file_contents_or_stdin conf.file)
end

def dump_ast(conf)
	puts Con::Parser.parse(Con::Lexer.lex(file_contents_or_stdin(conf.file)))
end

def evaluate(contents)
	begin
		ast = Con::Parser.parse(Con::Lexer.lex(contents))

#		Con::TypeChecking.new.visit ast
		ast.visit Con::TypeChecking.new, :postorder

		puts ast.to_s

	rescue RLTK::NotInLanguage => e
		puts 'Invalid input'

	rescue Con::UnknownVariable => e
		puts e.message
	end
end

def repl(conf)
	# TODO: If a file was given, its contents should be sourced into the
	# environment before the REPL loads.
	puts "Con v#{Con::VERSION} REPL (CTRL-D to exit)"
	loop do
		line = Readline.readline("Con > ", true)
		if not line
			puts
			break
		else
			evaluate line
		end
	end
end

conf = Configuration.new(ARGV)
case conf.mode
when :lex   then tokenize conf
when :parse then dump_ast conf
when :repl  then repl conf
else
	if conf.file
		evaluate File.open(conf.file).read
	elsif STDIN.isatty
		repl conf
	else
		evaluate STDIN.read
	end
end
