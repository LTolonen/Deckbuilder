/// @function PredicamentAddedGameEvent
/// @param predicament_data
function PredicamentAddedGameEvent(_predicament_data) : GameEvent(GAME_EVENT_TYPE.PREDICAMENT_ADDED) constructor
{
	predicament_data = _predicament_data;
	
	static toString = function()
	{
		return "Predicament added - "+predicament_data.name;	
	}
}