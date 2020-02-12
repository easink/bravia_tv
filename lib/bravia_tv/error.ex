# defmodule BraviaTV.Error do
#   @moduledoc false

#   defmodule Common do
# 1 	Any 	“error”: [1, “Any”] 	A generic error code which can be used with any error.
# 2 	Timeout 	“error”: [2, “Timeout”] 	For cases when the server cannot reply in time.
# 3 	Illegal Argument 	“error”: [3, “Illegal Argument”] 	For cases when the “params” value in the request does not follow API specifications.
# 5 	Illegal Request 	“error”: [5, “Illegal Request”] 	For cases when the request body is empty, has no ID or has an invalid ID, has no method, has no params, or the params is not an array.
# 7 	Illegal State 	“error”: [7, “Illegal State”] 	For cases when the server cannot handle the request at this time.
# 12 	No Such Method 	“error”: [12, “No Such Method”] 	For cases when the requested API does not exist.
# 14 	Unsupported Version 	“error”: [14, “Unsupported Version”] 	For cases when the requested version is not supported on the specified service.
# 15 	Unsupported Operation 	“error”: [15, “Unsupported Operation”] 	For cases when the server cannot handle the request with respect to the specified parameters.

#   end
# end
