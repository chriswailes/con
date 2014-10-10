require 'con/ast'

module Con
	NATIVE_LAMBDAS = {
		add: [
			NativeLambda.new([VarDecl.new(:x, :int), VarDecl.new(:y, :int)], nil) do

			end
		]
	}
end
