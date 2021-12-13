/// @function CardDiscardFromHandGameEvent
/// @param card_entity_id
/// @param card_data
function CardDiscardedFromHandGameEvent(_card_entity_id, _card_data) : GameEvent(GAME_EVENT_TYPE.CARD_DISCARDED_FROM_HAND) constructor
{
	card_entity_id = _card_entity_id;
	card_data = _card_data;
	
	static toString = function()
	{
		return "Card discarded from hand: "+card_data.name+" ("+string(card_entity_id)+")";	
	}
}