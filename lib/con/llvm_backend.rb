# encoding: UTF-8

require 'rltk/cg/contractor'

require 'con/ast'

module Con
	class LLVMBackend < RLTK::CG::Contractor
		def initialize(*args)
			super(*args)

			@lambda_counter = -1
		end

		on VarDef do |vardef|

		end

		on Lambda do |λ|
			param_types = λ.params.map { |p| visit p.type }

			@module.functions.add("lambda#{@lambda_counter += 1}", (visit λ.type)) do

			end
		end

		on NativeLambda do |λ|

		end

		on Application do |ap|

		end

		on Int do |i|
			RLTK::CG::Int.new(i.val)
		end

		on Float do |f|
			RLTK::CG::Float.new(f.val)
		end

		on VarRef do |varref|

		end
	end
end
