/// @function GUIDrawPileButton
/// @param gui
/// @param x
/// @param y
function GUIDrawPileButton(_gui,_x, _y) : GUIButton(_gui,GUI_LAYER_BUTTONS,_x,_y,100,30,"Draw Pile") constructor
{
	draw_pile_list = -1;
	
	/// @function update_draw_pile_list
	/// @oaram draw_pile_list
	static update_draw_pile_list = function(_draw_pile_list)
	{
		draw_pile_list = _draw_pile_list;
		if(draw_pile_list != -1)
			text = "Draw Pile ("+string(draw_pile_list.num_items)+")";	
	}
}