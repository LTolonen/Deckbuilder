/// @function GameMainGUIState
/// @param gui
/// @param input_request
function GameMainGUIState(_gui, _input_request) : GUIState(_gui, GUI_STATE_TYPE.GAME_MAIN) constructor
{
	input_request = _input_request;
}