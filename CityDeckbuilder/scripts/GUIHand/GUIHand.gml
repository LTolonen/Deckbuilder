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
			_gui_card.target_center_x = spread_item(width,gui_cards.num_items,GUI_CARD_WIDTH,i)+GUI_CARD_WIDTH div 2;
			_gui_card.target_center_y = y+height div 2;
		}
	}
}