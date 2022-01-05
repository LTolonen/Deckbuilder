/// @function GUIContainer
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
function GUIContainer(_gui, _depth, _x, _y, _width, _height) : GUIElement(_gui, _depth, _x, _y, _width, _height, "Container") constructor
{
	align_left_to_parent = false;
	align_right_to_parent = false;
	align_top_to_parent = false;
	align_bottom_to_parent = false;
}