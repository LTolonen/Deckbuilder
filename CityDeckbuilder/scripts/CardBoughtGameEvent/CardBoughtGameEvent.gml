/// @function CardBoughtGameEvent
/// @param card_entity_id
/// @param card_data
function CardBoughtGameEvent(_card_entity_id, _card_data) : GameEvent(GAME_EVENT_TYPE.CARD_BOUGHT) constructor
{
	card_entity_id = _card_entity_id;
	card_data = _card_data;
	
	static toString = function()
	{
		return "Card bought: "+card_data.name+" ("+string(card_entity_id)+")";	
	}
}