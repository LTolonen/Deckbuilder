/// @function CardAddedToShopGameEvent
/// @param card_entity_id
/// @param card_data
/// @param slot_index
function CardAddedToShopGameEvent(_card_entity_id, _card_data, _slot_index) : GameEvent(GAME_EVENT_TYPE.CARD_ADDED_TO_SHOP) constructor
{
	card_entity_id = _card_entity_id;
	card_data = _card_data;
	slot_index = _slot_index;
	
	static toString = function()
	{
		return "Card added to shop in position "+string(slot_index)+": "+card_data.name+" ("+string(card_entity_id)+")";	
	}
}