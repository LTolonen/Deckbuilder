/// @function GameWaitingGUIState
/// @param gui
function GameWaitingGUIState(_gui) : GUIState(_gui, GUI_STATE_TYPE.GAME_WAITING) constructor
{
	on_game_event = array_create(GAME_EVENT_TYPE.COUNT,-1);
	on_game_event[GAME_EVENT_TYPE.INPUT_REQUESTED] = game_gui_on_input_requested;
	on_game_event[GAME_EVENT_TYPE.CARD_DRAWN] = game_gui_on_card_drawn;
	on_game_event[GAME_EVENT_TYPE.CARD_DISCARDED_FROM_HAND] = game_gui_on_card_discarded_from_hand;
	on_game_event[GAME_EVENT_TYPE.RESOURCE_CHANGE] = game_gui_on_resource_change;
	on_game_event[GAME_EVENT_TYPE.CARD_ADDED_TO_SHOP] = game_gui_on_card_added_to_shop;
	on_game_event[GAME_EVENT_TYPE.CARD_REMOVED_FROM_SHOP] = game_gui_on_card_removed_from_shop;
	on_game_event[GAME_EVENT_TYPE.CARD_BOUGHT] = game_gui_on_card_bought;
	on_game_event[GAME_EVENT_TYPE.PREDICAMENT_ADDED] = game_gui_on_predicament_added;
	on_game_event[GAME_EVENT_TYPE.PREDICAMENT_REMOVED] = game_gui_on_predicament_removed;
	on_game_event[GAME_EVENT_TYPE.PREDICAMENT_TICKDOWN] = game_gui_on_predicament_tick_down;
	
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
		var _gui_card = new GUICard(gui,-100,300,_game_event.card_data, _game_event.card_entity_id, ZONE.HAND);
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
	
	/// @function game_gui_on_card_added_to_shop
	/// @param game_event
	static game_gui_on_card_added_to_shop = function(_game_event)
	{
		var _gui_card = new GUICard(gui,-100,-300,_game_event.card_data,_game_event.card_entity_id, ZONE.SHOP);
		gui.gui_shop.gui_cards[_game_event.slot_index] = _gui_card;
	}
	
	/// @function game_gui_on_card_removed_from_shop
	/// @param game_event
	static game_gui_on_card_removed_from_shop = function(_game_event)
	{
		var _gui_card = gui.gui_shop.gui_cards[_game_event.slot_index];
		gui.gui_shop.gui_cards[_game_event.slot_index] = -1;
		_gui_card.destroy();
	}
	
	/// @function game_gui_on_card_bought
	/// @param game_event
	static game_gui_on_card_bought = function(_game_event)
	{
		var _gui_card = gui.gui_entities[_game_event.card_entity_id];
		for(var i=0; i<gui.gui_shop.num_slots; i++)
		{
			if(gui.gui_shop.gui_cards[i] == -1)
				continue;
			if(gui.gui_shop.gui_cards[i].card_entity_id != _game_event.card_entity_id)
				continue;
			gui.gui_shop.gui_cards[i] = -1;
		}
		gui.gui_hand.gui_cards.add_item(_gui_card);
		_gui_card.zone = ZONE.HAND;
	}
	
	/// @function game_gui_on_predicament_added
	/// @param game_event
	static game_gui_on_predicament_added = function(_game_event)
	{
		gui.gui_predicament = new GUIPredicament(gui,640-GUI_PREDICAMENT_WIDTH-4,4,_game_event.predicament_data);
	}
	
	/// @function game_gui_on_predicament_removed
	/// @param game_event
	static game_gui_on_predicament_removed = function(_game_event)
	{
		gui.gui_predicament.destroy();
		gui.gui_predicament = -1;
	}
	
	/// @function game_gui_on_predicament_tick_down
	/// @param game_event
	static game_gui_on_predicament_tick_down = function(_game_event)
	{
		gui.gui_predicament.turns_remaining = _game_event.turns_remaining;	
	}
}