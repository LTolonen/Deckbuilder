/// @function MainInputRequest
/// @param game_state
function MainInputRequest(_game_state) : InputRequest(INPUT_REQUEST_TYPE.MAIN) constructor
{
	playable_cards = get_playable_cards(_game_state);
	buyable_cards = get_buyable_cards(_game_state);
	can_reroll_shop = _game_state.resources[RESOURCE.MONEY] >= _game_state.shop.reroll_cost;
	
	static toString = function()
	{
		return "Main";	
	}
	
	static get_playable_cards = function(_game_state)
	{
		var _playable_cards = new List();
		for(var i=0; i<_game_state.hand.num_items; i++)
		{
			var _card = _game_state.hand.items[i];
			if(_card.card_can_be_played(_game_state))
			{
				_playable_cards.add_item(_card.entity_id);
			}
		}
		return _playable_cards;
	}
	
	static get_buyable_cards = function(_game_state)
	{
		var _buyable_cards = new List();
		for(var i=0; i<_game_state.shop.num_slots; i++)
		{
			var _card = _game_state.shop.cards[i];
			if(_card == -1)
				continue;
			if(_card.card_can_be_bought(_game_state))
			{
				_buyable_cards.add_item(_card.entity_id);	
			}
		}
		return _buyable_cards;
	}
	
	static input_request_validate_input = function(_input, _game_state)
	{
		switch(_input.input_type)
		{
			case INPUT_TYPE.TURN_END:
				return true;
			case INPUT_TYPE.REROLL_SHOP:
				return can_reroll_shop;
			case INPUT_TYPE.PLAY_CARD:
				var _found_in_hand = false;
				for(var i=0; i<_game_state.hand.num_items; i++)
				{
					if(_game_state.hand.items[i].entity_id == _input.card_entity_id)
					{
						_found_in_hand = true;
						break;
					}
				}
				if(!_found_in_hand)
					return false;
				if(playable_cards.find_item_index(_input.card_entity_id) == -1)
					return false;
				return true;
			case INPUT_TYPE.BUY_CARD:
				var _found_in_shop = false;
				for(var i=0; i<_game_state.shop.num_slots; i++)
				{
					if(_game_state.shop.cards[i] == -1)
						continue;
					if(_game_state.shop.cards[i].entity_id == _input.card_entity_id)
					{
						_found_in_shop = true;
						break;
					}
				}
				if(!_found_in_shop)
					return false;
				if(buyable_cards.find_item_index(_input.card_entity_id) == -1)
					return false;
				return true;
				
		}
	}
}