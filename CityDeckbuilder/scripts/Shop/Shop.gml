#macro SHOP_NUM_SLOTS 5

/// @function Shop
/// @param num_slots
function Shop(_num_slots) constructor
{
	num_slots = _num_slots;
	cards = array_create(num_slots,-1);
	
	reroll_cost = 0;
	
	/// @function shop_populate
	/// @param game_state
	static shop_populate = function(_game_state)
	{
		for(var i=0; i<num_slots; i++)
		{
			if(cards[i] == -1)
			{
				var _card_data = _game_state.card_set.card_set_choose_card()
				cards[i] = new Card(_game_state.entity_set, _card_data, new CardLocation(ZONE.SHOP,i));
				
				_game_state.game_event_subject_notify(new CardAddedToShopGameEvent(cards[i].entity_id,_card_data,i));
			}
		}
	}
	
	/// @function shop_reroll
	/// @param game_state
	static shop_reroll = function(_game_state)
	{
		reroll_cost++;
		_game_state.game_event_subject_notify(new ShopRerollCostChangedGameEvent(reroll_cost));
		for(var i=0; i<num_slots; i++)
		{
			if(cards[i] == -1)
				continue;
			var _card = cards[i];
			cards[i] = -1;
			_game_state.game_event_subject_notify(new CardRemovedFromShopGameEvent(_card.entity_id,_card.card_data,i));
			_card.entity_destroy();
		}
		shop_populate(_game_state);
	}
}