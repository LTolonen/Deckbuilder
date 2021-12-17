/// @function PredicamentRemovedGameEvent
/// @param predicament_data
function PredicamentRemovedGameEvent(_predicament_data) : GameEvent(GAME_EVENT_TYPE.PREDICAMENT_REMOVED) constructor
{
	predicament_data = _predicament_data;
	
	static toString = function()
	{
		return "Predicament removed - "+predicament_data.name;	
	}
}