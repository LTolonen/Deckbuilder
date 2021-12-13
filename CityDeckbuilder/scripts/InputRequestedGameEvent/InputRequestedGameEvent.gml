/// @function InputRequestedGameEvent
/// @param input_request
function InputRequestedGameEvent(_input_request) : GameEvent(GAME_EVENT_TYPE.INPUT_REQUESTED) constructor
{
	input_request = _input_request;
	
	static toString = function()
	{
		return "Input Requested - "+string(input_request);	
	}
}