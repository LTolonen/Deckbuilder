#macro SHOP_NUM_SLOTS 5

/// @function Shop
/// @param num_slots
function Shop(_num_slots) constructor
{
	num_slots = _num_slots;
	cards = array_create(num_slots,-1);
	
	/// @function shop_populate
	/// @param game_state
	static shop_populate = function(_game_state)
	{
		for(var i=0; i<num_slots; i++)
		{
			if(cards[i] == -1)
			{
				var _card_data = _game_state.card_set.card_set_choose_card()
				cards[i] = new Card(_game_state.entity_set, _card_data);
				
				_game_state.game_event_subject_notify(new CardAddedToShopGameEvent(cards[i].entity_id,_card_data,i));
			}
		}
	}
}