enum GAME_EVENT_TYPE
{
	TURN_BEGIN,
	TURN_END,
	CARD_DRAWN,
	CARD_DISCARDED_FROM_HAND,
	CARD_PLAYED,
	CARD_ADDED_TO_SHOP,
	CARD_REMOVED_FROM_SHOP,
	CARD_BOUGHT,
	SHUFFLE,
	RESOURCE_CHANGE,
	INPUT_REQUESTED,
	PREDICAMENT_ADDED,
	PREDICAMENT_REMOVED,
	COUNT
}

/// @function GameEvent
/// @param game_event_type
function GameEvent(_game_event_type) constructor
{
	game_event_type = _game_event_type;
	
	static toString = function()
	{
		return "Generic game event";	
	}
}