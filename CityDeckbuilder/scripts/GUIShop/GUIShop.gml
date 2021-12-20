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
	hoverable = false;
	
	static update = function()
	{
		for(var i=0; i<num_slots; i++)
		{
			if(gui_cards[i] == -1)
				continue;
			var _gui_card = gui_cards[i];
			_gui_card.target_center_x = spread_item(width,num_slots,GUI_CARD_COLLAPSED_WIDTH,i)+GUI_CARD_COLLAPSED_WIDTH div 2;
			_gui_card.target_center_y = y+height div 2;
		}
	}
		
	/// @function gui_shop_add_card
	/// @param gui_card
	/// @param position
	static gui_shop_add_card = function(_gui_card, _position)
	{
		gui_cards[_position] = _gui_card;
		_gui_card.card_location = new CardLocation(ZONE.SHOP,_position);
		_gui_card.non_hover_depth = GUI_LAYER_CARDS - _position;
	}
	
	/// @function gui_shop_remove_card
	/// @param gui_card
	static gui_shop_remove_card = function(_gui_card)
	{
		if(_gui_card.card_location.zone != ZONE.SHOP)
			return;
		gui_cards[_gui_card.card_location.position] = -1;
		_gui_card.card_location = new CardLocation(ZONE.NONE,-1);
	}
}