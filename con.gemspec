# Author:		Chris Wailes <chris.wailes@gmail.com>
# Project: 	Filigree
# Date:		2013/4/19
# Description:	Gem specification for the Filigree project.

require File.expand_path("../lib/con/version", __FILE__)

Gem::Specification.new do |s|
	s.platform = Gem::Platform::RUBY
	
	s.name		= 'con'
	s.version		= Con::VERSION
	s.summary		= 'A simple compiler for a Scheme-like language.'
	s.description	= 'Con is a JIT and ahead of time compiler for a simple ' +
	                 'like language.'
	
	s.files = [
		'LICENSE',
		'AUTHORS',
		'README.md',
		'Rakefile',
	] +
	Dir.glob('lib/**/*.rb')
	
	s.test_files = Dir['test/**/*.rb']
			
	s.require_path	= 'lib'
	
	s.author   = 'Chris Wailes'
	s.email    = 'chris.wailes+con@gmail.com'
	s.homepage = 'https://github.com/chriswailes/con'
	s.license  = 'BSD'
	
	s.required_ruby_version = '>= 2.0.0'
	
	################
	# Dependencies #
	################
	
	s.add_dependency('filigree')
	s.add_dependency('rltk')
	
	############################
	# Development Dependencies #
	############################
	
	s.add_development_dependency('bundler')
	s.add_development_dependency('flay')
	s.add_development_dependency('flog')
	s.add_development_dependency('minitest')
	s.add_development_dependency('pry')
	s.add_development_dependency('rake')
	s.add_development_dependency('rake-notes')
	s.add_development_dependency('reek')
	s.add_development_dependency('rubygems-tasks')
	s.add_development_dependency('simplecov')
	s.add_development_dependency('yard', '>= 0.8.1')
end
