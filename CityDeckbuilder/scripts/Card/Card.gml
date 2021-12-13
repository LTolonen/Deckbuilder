/// @function Card
/// @param entity_set
/// @param card_data
function Card(_entity_set, _card_data) : Entity(_entity_set,"Card") constructor
{
	card_data = _card_data;
	
	/// @function card_can_be_played
	/// @param game_state
	static card_can_be_played = function(_game_state)
	{
		if(!card_data.is_playable)
			return false;
		if(card_data.energy_cost > _game_state.resources[RESOURCE.ENERGY])
			return false;
		return true;	
	}
}