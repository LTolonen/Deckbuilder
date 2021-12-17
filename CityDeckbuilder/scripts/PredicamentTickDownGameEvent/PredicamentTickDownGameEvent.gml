/// @function PredicamentTickDownGameEvent
/// @param predicament_data
/// @param turns_remaining
function PredicamentTickDownGameEvent(_predicament_data, _turns_remaining) : GameEvent(GAME_EVENT_TYPE.PREDICAMENT_TICKDOWN) constructor
{
	predicament_data = _predicament_data;
	turns_remaining = _turns_remaining;
	
	static toString = function()
	{
		return "Predicament ticked down to "+string(turns_remaining);	
	}
}