function GameGUI() : GUI() constructor
{
	input_provider = new InputProvider();
	gui_entities = array_create(0);
	
	gui_shop = new GUIShop(self,0,0,SHOP_NUM_SLOTS*(GUI_CARD_COLLAPSED_WIDTH+8),GUI_CARD_COLLAPSED_HEIGHT+6,SHOP_NUM_SLOTS);
	gui_resource_indicators = array_create(RESOURCE.COUNT,-1);
	for(var i=0; i<RESOURCE.COUNT; i++)
	{
		gui_resource_indicators[i] = new GUIResourceIndicator(self,640-GUI_RESOURCE_INDICATOR_WIDTH*(RESOURCE.COUNT-i),160,i,0);
	}
	gui_hand = new GUIHand(self,20,240,600,120);
	gui_play_area = new GUIPlayArea(self,0,120,400,120);
	gui_end_turn_button = new GUIEndTurnButton(self,640-80-27,210);
	gui_reroll_button = new GUIRerollButton(self,10,gui_shop.height+20);
	gui_predicament = -1;
	gui_log = new GUILog(self,240,0);

	game_event_queue = new List();
	
	enter_gui_state(new GameWaitingGUIState(self));

	/// @function on_notify
	/// @param game_event
	static on_notify = function(_game_event)
	{
		game_event_queue.add_item(_game_event);
	}
	
	/// @function game_gui_provide_inpit
	/// @param input
	static game_gui_provide_input = function(_input)
	{
		var _successful = input_provider.input_provider_provide_input(_input);
		if(_successful)
			enter_gui_state(new GameWaitingGUIState(self));
	}
}