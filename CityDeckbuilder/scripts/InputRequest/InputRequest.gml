enum INPUT_REQUEST_TYPE
{
	GAME_START,
	MAIN	
}

/// @function InputRequest
/// @param input_request_type
function InputRequest() constructor
{
	/// @function input_request_validate_input
	/// @param input
	/// @param game_state
	static input_request_validate_input = function(_input, _game_state)
	{
		return true;	
	}
}