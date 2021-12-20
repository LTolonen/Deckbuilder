/// @function PredicamentAddedGameEvent
/// @param predicament_data
/// @param level
function PredicamentAddedGameEvent(_predicament_data, _level) : GameEvent(GAME_EVENT_TYPE.PREDICAMENT_ADDED) constructor
{
	predicament_data = _predicament_data;
	level = _level;
	
	static toString = function()
	{
		return "Predicament added - "+predicament_data.name+" (Level "+string(level)+")";	
	}
}