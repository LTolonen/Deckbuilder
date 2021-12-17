/// @function GameController
/// @param card_set
/// @param predicament_set
function GameController(_card_set, _predicament_set) constructor
{
	card_set = _card_set;
	predicament_set = _predicament_set;
	game_state = new GameState(_card_set, _predicament_set);
	current_input_request = -1;
	input_provider = -1;
	
	on_input = array_create(INPUT_TYPE.COUNT,-1);
	on_input[INPUT_TYPE.TURN_END] = controller_turn_end;
	on_input[INPUT_TYPE.PLAY_CARD] = controller_play_card;
	on_input[INPUT_TYPE.BUY_CARD] = controller_buy_card;
	on_input[INPUT_TYPE.REROLL_SHOP] = controller_reroll_shop;
	
	static controller_init = function()
	{
		game_state.game_init();
		controller_request_input(new MainInputRequest(game_state));
	}
	
	/// @function controller_request_input
	/// @param input_request
	static controller_request_input = function(_input_request)
	{
		current_input_request = _input_request;
		if(input_provider == -1)
			return -1;
		input_provider.current_input_request = _input_request;
		
		game_state.game_event_subject_notify(new InputRequestedGameEvent(_input_request));
	}
	
	/// @function controller_process_input
	/// @param input
	static controller_process_input = function(_input)
	{
		if(current_input_request == -1)
			return false;
			
		if(!current_input_request.input_request_validate_input(_input,game_state))
			return false;
			
		if(on_input[_input.input_type] == -1)
			return false;
			
		current_input_request = -1;
		input_provider.current_input_request = -1;
		on_input[_input.input_type](_input);
		return true;
	}
	
	/// @function controller_turn_end
	/// @param input
	static controller_turn_end = function(_input)
	{
		game_state.game_turn_end();
		game_state.game_turn_begin();
		controller_request_input(new MainInputRequest(game_state));
	}
	
	/// @function controller_play_card
	/// @param input
	static controller_play_card = function(_input)
	{
		game_state.game_play_card(_input.card_entity_id);
		controller_request_input(new MainInputRequest(game_state));
	}
	
	/// @function controller_buy_card
	/// @param input
	static controller_buy_card = function(_input)
	{
		game_state.game_buy_card(_input.card_entity_id);
		controller_request_input(new MainInputRequest(game_state));
	}
	
	/// @function controller_reroll_shop
	/// @param input
	static controller_reroll_shop = function(_input)
	{
		game_state.game_reroll_shop();
		controller_request_input(new MainInputRequest(game_state));
	}
}