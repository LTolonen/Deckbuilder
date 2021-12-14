/// @function GUIShop
/// @param gui
/// @param x
/// @param y
/// @param width
/// @param height
function GUIShop(_gui, _x, _y, _width, _height) : GUIElement(_gui, GUI_LAYER_CARDS,_x, _y, _width, _height, "Shop") constructor
{
	gui_cards = array_create(SHOP_NUM_SLOTS,-1);
	
	static update = function()
	{
		for(var i=0; i<SHOP_NUM_SLOTS; i++)
		{
			if(gui_cards[i] == -1)
				continue;
			var _gui_card = gui_cards[i];
			_gui_card.target_center_x = spread_item(width,SHOP_NUM_SLOTS,GUI_CARD_WIDTH,i)+GUI_CARD_WIDTH div 2;
			_gui_card.target_center_y = y+height div 2;
		}
	}
}