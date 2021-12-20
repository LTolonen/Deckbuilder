/// @function GUIDiscardPileButton
/// @param gui
/// @param x
/// @param y
function GUIDiscardPileButton(_gui,_x, _y) : GUIButton(_gui,GUI_LAYER_BUTTONS,_x,_y,100,30,"Discard Pile") constructor
{
	discard_pile_list = -1;
	
	/// @function update_discard_pile_list
	/// @oaram discard_pile_list
	static update_discard_pile_list = function(_discard_pile_list)
	{
		discard_pile_list = _discard_pile_list;
		if(discard_pile_list != -1)
			text = "Discard Pile ("+string(discard_pile_list.num_items)+")";	
	}
}