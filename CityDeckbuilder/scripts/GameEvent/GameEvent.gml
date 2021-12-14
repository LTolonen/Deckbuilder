enum GAME_EVENT_TYPE
{
	TURN_BEGIN,
	TURN_END,
	CARD_DRAWN,
	CARD_DISCARDED_FROM_HAND,
	CARD_PLAYED,
	CARD_ADDED_TO_SHOP,
	SHUFFLE,
	RESOURCE_CHANGE,
	INPUT_REQUESTED,
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