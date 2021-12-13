/// @function MainInputRequest
/// @param game_state
function MainInputRequest(_game_state) : InputRequest(INPUT_REQUEST_TYPE.MAIN) constructor
{
	playable_cards = get_playable_cards(_game_state);
	
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
		}
	}
}