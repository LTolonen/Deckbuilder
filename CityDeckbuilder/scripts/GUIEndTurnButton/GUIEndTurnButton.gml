#macro GUI_LAYER_BUTTONS 0
/// @function GUIEndTurnButton
/// @param gui
/// @param x
/// @param y
function GUIEndTurnButton(_gui,_x, _y) : GUIButton(_gui,GUI_LAYER_BUTTONS,_x,_y,80,30,"End Turn") constructor
{
	static on_click = function()
	{
		if(gui.gui_state.gui_state_type == GUI_STATE_TYPE.GAME_MAIN)
		{
			gui.game_gui_provide_input(new TurnEndInput());
		}
	}
}