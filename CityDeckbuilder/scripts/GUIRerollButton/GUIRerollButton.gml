/// @function GUIRerollButton
/// @param gui
/// @param x
/// @param y
function GUIRerollButton(_gui,_x, _y) : GUIButton(_gui,GUI_LAYER_BUTTONS,_x,_y,80,30,"Reroll") constructor
{
	static on_click = function()
	{
		if(gui.gui_state.gui_state_type == GUI_STATE_TYPE.GAME_MAIN)
		{
			gui.game_gui_provide_input(new RerollShopInput());
		}
	}
}