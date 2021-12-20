/// @function GUIHand
/// @param gui
/// @param x
/// @param y
/// @param width
/// @param height
function GUIHand(_gui, _x, _y, _width, _height) : GUIElement(_gui, GUI_LAYER_CARDS,_x, _y, _width, _height, "Hand") constructor
{
	gui_cards = new List();
	
	static update = function()
	{
		for(var i=0; i<gui_cards.num_items; i++)
		{
			var _gui_card = gui_cards.items[i];
			_gui_card.target_center_x = x+spread_item(width,gui_cards.num_items,GUI_CARD_WIDTH,i)+GUI_CARD_WIDTH div 2;
			_gui_card.target_center_y = y+height div 2;
		}
	}
	
	/// @function gui_hand_add_card
	/// @param gui_card
	static gui_hand_add_card = function(_gui_card)
	{
		gui_cards.add_item(_gui_card);
		_gui_card.card_location = new CardLocation(ZONE.HAND,-1);
		_gui_card.non_hover_depth = GUI_LAYER_CARDS - gui_cards.num_items;
	}
	
	/// @function gui_hand_remove_card
	/// @param gui_card
	static gui_hand_remove_card = function(_gui_card)
	{
		if(_gui_card.card_location.zone != ZONE.HAND)
			return;
		gui_cards.remove_item(_gui_card);
		_gui_card.card_location = new CardLocation(ZONE.NONE,-1);
	}
}