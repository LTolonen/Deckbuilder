/// @function GameWaitingGUIState
/// @param gui
function GameWaitingGUIState(_gui) : GUIState(_gui, GUI_STATE_TYPE.GAME_WAITING) constructor
{
	on_game_event = array_create(GAME_EVENT_TYPE.COUNT,-1);
	on_game_event[GAME_EVENT_TYPE.INPUT_REQUESTED] = game_gui_on_input_requested;
	on_game_event[GAME_EVENT_TYPE.CARD_DRAWN] = game_gui_on_card_drawn;
	on_game_event[GAME_EVENT_TYPE.CARD_DISCARDED_FROM_HAND] = game_gui_on_card_discarded_from_hand;
	on_game_event[GAME_EVENT_TYPE.RESOURCE_CHANGE] = game_gui_on_resource_change;
	
	static update = function()
	{
		if(gui.game_event_queue.num_items <= 0)
			return;
			
		var _game_event = gui.game_event_queue.pop_first_item();
		gui.gui_log.gui_log_add_line(string(_game_event));
		
		if(on_game_event[_game_event.game_event_type] != -1)
		{
			on_game_event[_game_event.game_event_type](_game_event);
		}
	}
	
	/// @function game_gui_on_input_requested
	/// @param game_event
	static game_gui_on_input_requested = function(_game_event)
	{
		gui.enter_gui_state(new GameMainGUIState(gui,_game_event.input_request));	
	}
	
	/// @function game_gui_on_card_drawn
	/// @param game_event
	static game_gui_on_card_drawn = function(_game_event)
	{
		var _gui_card = new GUICard(gui,-100,300,_game_event.card_data, _game_event.card_entity_id);
		gui.gui_hand.gui_cards.add_item(_gui_card);
	}
	
	/// @function game_gui_on_card_discarded_from_hand
	/// @param game_event
	static game_gui_on_card_discarded_from_hand = function(_game_event)
	{
		for(var i=0; i<gui.gui_hand.gui_cards.num_items; i++)
		{
			if(gui.gui_hand.gui_cards.items[i].card_entity_id == _game_event.card_entity_id)
			{
				var _gui_card = gui.gui_hand.gui_cards.items[i];
				gui.gui_hand.gui_cards.remove_item_at_index(i);
				_gui_card.destroy();
				break;
			}
		}
	}
	
	/// @function game_gui_on_resource_change
	/// @param game_event
	static game_gui_on_resource_change = function(_game_event)
	{
		var _gui_resource_indicator = gui.gui_resource_indicators[_game_event.resource];
		_gui_resource_indicator.amount += _game_event.change_amount;
	}
}