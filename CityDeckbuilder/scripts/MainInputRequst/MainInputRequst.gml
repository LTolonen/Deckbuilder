/// @function MainInputRequest
/// @param game_state
function MainInputRequest(_game_state) : InputRequest(INPUT_REQUEST_TYPE.MAIN) constructor
{
	playable_cards = get_playable_cards(_game_state);
	buyable_cards = get_buyable_cards(_game_state);
	
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
		for(var i=0; i<SHOP_NUM_SLOTS; i++)
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
				var _found_in_playable_cards = false;
				for(var i=0; i<playable_cards.num_items; i++)
				{
					if(playable_cards.items[i] == _input.card_entity_id)
					{
						_found_in_playable_cards = true;
						break;
					}
				}
				if(!_found_in_playable_cards)
					return false;
				return true;
			case INPUT_TYPE.BUY_CARD:
				var _found_in_shop = false;
				for(var i=0; i<SHOP_NUM_SLOTS; i++)
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
				var _found_in_buyable_cards = false;
				for(var i=0; i<buyable_cards.num_items; i++)
				{
					if(buyable_cards.items[i] == _input.card_entity_id)
					{
						_found_in_buyable_cards = true;
						break;
					}
				}
				if(!_found_in_buyable_cards)
					return false;
				return true;
				
		}
	}
}