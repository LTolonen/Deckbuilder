enum GUI_STATE_TYPE
{
	NONE,
	GAME_WAITING,
	GAME_MAIN
}

/// @function GUIState
/// @param gui
/// @param gui_state_type
function GUIState(_gui, _gui_state_type) constructor
{
	gui = _gui;
	gui_state_type = _gui_state_type;

	static update = -1;
}