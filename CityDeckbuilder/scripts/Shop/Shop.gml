#macro SHOP_NUM_SLOTS 5

function Shop() constructor
{
	cards = array_create(SHOP_NUM_SLOTS,-1);
	
	/// @function shop_populate
	/// @param game_state
	static shop_populate = function(_game_state)
	{
		for(var i=0; i<SHOP_NUM_SLOTS; i++)
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