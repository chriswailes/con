# Author:      Chris Wailes <chris.wailes@gmail.com>
# Project:     Con
# Date:        2014/10/10
# Description: This file contains classes and methods for the type system.

############
# Requires #
############

# Standard Library
require 'singleton'

# Filigree
require 'filigree/match'

#######################
# Classes and Modules #
#######################

module Con
	class Type

	end

	class IntType < Type
		include Singleton

		def to_s
			'int'
		end
	end

	class FloatType < Type
		include Singleton

		def to_s
			'float'
		end
	end

	class FunctionType < Type
		include Filigree::Destructurable

		attr_accessor :param_types
		attr_accessor :return_type

		def destructure(_)
			[@param_types, @return_type]
		end

		def initialize(param_types, return_type)
			@param_types = param_types
			@return_type = return_type
		end

		def to_s
			if @param_types.emtpy?
				"'() -> #{@return_type}"
			else
				@param_types.map(&:to_s).join(' -> ') + " -> #{@return_type}"
			end
		end
	end

	class ConsType < Type
		attr_accessor :element_type

		def destructure(_)
			[@element_type]
		end

		def intiailize(element_type)
			@element_type = element_type
		end
	end
end
