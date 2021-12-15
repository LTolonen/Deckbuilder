/// @function GUIShop
/// @param gui
/// @param x
/// @param y
/// @param width
/// @param height
/// @param num_slots
function GUIShop(_gui, _x, _y, _width, _height, _num_slots) : GUIElement(_gui, GUI_LAYER_CARDS,_x, _y, _width, _height, "Shop") constructor
{
	num_slots = _num_slots;
	gui_cards = array_create(num_slots,-1);
	
	static update = function()
	{
		for(var i=0; i<num_slots; i++)
		{
			if(gui_cards[i] == -1)
				continue;
			var _gui_card = gui_cards[i];
			_gui_card.target_center_x = spread_item(width,num_slots,GUI_CARD_WIDTH,i)+GUI_CARD_WIDTH div 2;
			_gui_card.target_center_y = y+height div 2;
		}
	}
}