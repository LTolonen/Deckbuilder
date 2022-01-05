/// @function Card
/// @param entity_set
/// @param card_data
/// @param card_location
function Card(_entity_set, _card_data, _card_location) : Entity(_entity_set,"Card") constructor
{
	card_data = _card_data;
	card_location = _card_location;
	
	/// @function card_can_be_played
	/// @param game_state
	static card_can_be_played = function(_game_state)
	{
		if(!card_data.is_playable)
			return false;
		if(card_location.zone != ZONE.HAND)
			return false;
		if(card_data.worker_cost > _game_state.resources[RESOURCE.WORKERS])
			return false;
		return true;	
	}
	
	/// @function card_can_be_bought
	/// @param game_state
	static card_can_be_bought = function(_game_state)
	{
		if(card_location.zone != ZONE.SHOP)
			return false;
		if(card_data.buy_cost > _game_state.resources[RESOURCE.MONEY])
			return false;
		return true;	
	}
}