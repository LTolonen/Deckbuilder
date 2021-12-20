#macro SHOP_NUM_SLOTS 5

/// @function Shop
/// @param num_slots
/// @param card_set
function Shop(_num_slots, _card_set) constructor
{
	num_slots = _num_slots;
	cards = array_create(num_slots,-1);
	card_pools = array_create(num_slots,-1);
	card_pools[0] = _card_set.card_pool_money;
	card_pools[1] = _card_set.card_pool_resources;
	for(var i=2; i<num_slots; i++)
	{
		card_pools[i] = _card_set.card_pool_general;	
	}
	
	reroll_cost = 1;
	
	/// @function shop_populate
	/// @param game_state
	static shop_populate = function(_game_state)
	{
		for(var i=0; i<num_slots; i++)
		{
			if(cards[i] == -1)
			{
				var _card_data = card_pools[i].pool_choose_item();
				cards[i] = new Card(_game_state.entity_set, _card_data, new CardLocation(ZONE.SHOP,i));
				
				_game_state.game_event_subject_notify(new CardAddedToShopGameEvent(cards[i].entity_id,_card_data,i));
			}
		}
	}
	
	/// @function shop_reroll
	/// @param game_state
	static shop_reroll = function(_game_state)
	{
		shop_set_reroll_cost(_game_state,reroll_cost+1);
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
	
	/// @function shop_set_reroll_cost
	/// @param game_state
	/// @param reroll_cost
	static shop_set_reroll_cost = function(_game_state, _reroll_cost)
	{
		if(reroll_cost == _reroll_cost)
			return;
		reroll_cost = _reroll_cost;
		_game_state.game_event_subject_notify(new ShopRerollCostChangedGameEvent(reroll_cost));
	}
}