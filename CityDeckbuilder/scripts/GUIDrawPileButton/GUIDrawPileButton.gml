/// @function GUIDrawPileButton
/// @param gui
/// @param x
/// @param y
function GUIDrawPileButton(_gui,_x, _y) : GUIElement(_gui,GUI_LAYER_BUTTONS,_x,_y,26,30,"DrawPileButton") constructor
{
	draw_pile_list = -1;
	text = "";
	text_width = 0;
	text_height = 7
	text_box_width = text_width + 4;
	text_box_height = text_height + 4;
	text_x = width;
	text_y = height - (text_height) div 2;
	text_box_x1 = text_x - text_box_width div 2;
	text_box_x2 = text_box_x1 + text_box_width - 1;
	text_box_y1 = text_y - 2;
	text_box_y2 = text_box_y1 + text_box_height - 1;
	
	static draw = function()
	{
		draw_sprite(SprDeckButtons,0,x,y);
		
		draw_cornered_rectangle(x+text_box_x1,y+text_box_y1,x+text_box_x2,y+text_box_y2,COLOUR.RED,SprCornerRounded2Px);
		
		draw_set_color(COLOUR.WHITE);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_font(FontVector7);
		draw_text(x+text_x,y+text_y,text);
	}
	
	/// @function update_draw_pile_list
	/// @oaram draw_pile_list
	static update_draw_pile_list = function(_draw_pile_list)
	{
		draw_pile_list = _draw_pile_list;
		if(draw_pile_list != -1)
		{
			text = string(draw_pile_list.num_items);
			draw_set_font(FontVector7);
			text_width = string_width(text)-1;
			text_box_width = text_width + 4;
			text_box_height = text_height + 4;
			text_x = width-1;
			text_y = height - (text_height) div 2 - 3;
			text_box_x1 = text_x - text_box_width div 2 - 1;
			text_box_x2 = text_box_x1 + text_box_width - 1;
			text_box_y1 = text_y - 2;
			text_box_y2 = text_box_y1 + text_box_height - 1;
		}
	}
}