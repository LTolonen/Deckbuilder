/// @function TurnBeginGameEvent
/// @param turn_number
function TurnBeginGameEvent(_turn_number) : GameEvent(GAME_EVENT_TYPE.TURN_BEGIN) constructor
{
	turn_number = _turn_number;
	
	static toString = function()
	{
		return "Turn Begin (Turn "+string(turn_number)+")";	
	}
}