#macro GUI_TOP_PANEL_HEIGHT 30
#macro GUI_HAND_HEIGHT 120
#macro GUI_SIDE_PANEL_WIDTH 180
#macro GUI_PREDICAMENT_AREA_HEIGHT 100
function GameGUI() : GUI() constructor
{
	input_provider = new InputProvider();
	gui_entities = array_create(0);
	
	main_vertical_group = new GUIVerticalGroup(self,0,0,0,canvas.width,canvas.height);
	main_vertical_group.set_parent_element(canvas);
	main_vertical_group.set_alignment_to_parent_element(true,true,true,true);
	var _top_item = new GUIVerticalGroupItem(self,main_vertical_group,-1000,TOP_PANEL_HEIGHT,0);
	var _center_item = new GUIVerticalGroupItem(self,main_vertical_group,-1000,0,1);
	var _top_item = new GUIVerticalGroupItem(self,main_vertical_group,-1000,GUI_HAND_HEIGHT,0);
	main_vertical_group.gui_group_align_items();
	
	horizontal_group = new GUIHorizontalGroup(self,0,0,0,0,0);
	horizontal_group.set_parent_element(_center_item);
	horizontal_group.set_alignment_to_parent_element(true,true,true,true);
	var _left_item = new GUIHorizontalGroupItem(self,horizontal_group,0,0,1);
	var _right_item = new GUIHorizontalGroupItem(self,horizontal_group,0,GUI_SIDE_PANEL_WIDTH,0);
	horizontal_group.fit_to_parent_element();
	horizontal_group.gui_group_align_items();
	
	panel_vertical_group = new GUIVerticalGroup(self,0,0,0,0,0);
	panel_vertical_group.set_parent_element(_left_item);
	panel_vertical_group.set_alignment_to_parent_element(true,true,true,true);
	var _predicament_item = new GUIVerticalGroupItem(self,panel_vertical_group,0,GUI_PREDICAMENT_AREA_HEIGHT,0);
	var _gap_item = new GUIVerticalGroupItem(self,panel_vertical_group,0,0,1);
	panel_vertical_group.fit_to_parent_element();
	panel_vertical_group.gui_group_align_items();
	
	gui_shop = new GUIShop(self,0,0,SHOP_NUM_SLOTS*(GUI_CARD_COLLAPSED_WIDTH+8),GUI_CARD_COLLAPSED_HEIGHT+6,SHOP_NUM_SLOTS);
	gui_resource_indicators = array_create(RESOURCE.COUNT,-1);
	for(var i=0; i<RESOURCE.COUNT; i++)
	{
		gui_resource_indicators[i] = new GUIResourceIndicator(self,640-10-GUI_RESOURCE_INDICATOR_WIDTH*(RESOURCE.COUNT-i),160,i,0);
	}
	gui_top_panel = new GUITopPanel(self);
	gui_hand = new GUIHand(self,0,240,640,120);
	gui_hand.set_parent_element(canvas);
	gui_play_area = new GUIPlayArea(self,0,120,400,120);
	gui_end_turn_button = new GUIEndTurnButton(self,640-80-10,210);
	gui_draw_pile_button = new GUIDrawPileButton(self,640-80-30-56,210);
	gui_discard_pile_button = new GUIDiscardPileButton(self,640-80-20-28,210);
	gui_reroll_button = new GUIRerollButton(self,10,gui_shop.height+20);
	gui_predicament = -1;
	gui_log = new GUILog(self,240,0);
	gui_card_selector = -1;
	
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