#macro GUI_LAYER_PLAY_AREA 200

/// @function GUIPlayArea
/// @param gui
/// @param x
/// @param y
/// @param width
/// @param height
function GUIPlayArea(_gui, _x, _y, _width, _height) : GUIElement(_gui, GUI_LAYER_PLAY_AREA,_x, _y, _width, _height, "PlayArea") constructor
{
	gui_cards = new List();
	card_grouping = 3;
	card_separation = 15;
	
	static update = function()
	{
		var _num_cards = gui_cards.num_items;
		var _num_groups = ceil(_num_cards / card_grouping);
		var _total_width = _num_groups * (GUI_CARD_COLLAPSED_WIDTH + card_separation * card_grouping);
		for(var i=0; i<gui_cards.num_items; i++)
		{
			var _gui_card = gui_cards.items[i];
			_gui_card.target_center_x = x + width - _total_width + card_separation * i + GUI_CARD_COLLAPSED_WIDTH / 2 + GUI_CARD_COLLAPSED_WIDTH * (i div card_grouping);
			_gui_card.target_center_y = y + card_separation * (i mod card_grouping) + GUI_CARD_COLLAPSED_HEIGHT / 2;
		}
	}
	
	/// @function gui_play_area_add_card
	/// @param gui_card
	static gui_play_area_add_card = function(_gui_card)
	{
		gui_cards.add_item(_gui_card);
		_gui_card.card_location = new CardLocation(ZONE.PLAY,-1);
		_gui_card.non_hover_depth = GUI_LAYER_PLAY_AREA - gui_cards.num_items;
	}
	
	/// @function gui_play_area_remove_all_cards
	static gui_play_area_remove_all_cards = function()
	{
		for(var i=0; i<gui_cards.num_items; i++)
		{
			var _gui_card = gui_cards.items[i];
			_gui_card.destroy();
		}
		gui_cards.empty_list();
	}
}