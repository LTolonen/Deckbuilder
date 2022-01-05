#macro GUI_LAYER_BACKGROUND 1000
#macro TOP_PANEL_HEIGHT 30
/// @function GUITopPanel
/// @param gui
function GUITopPanel(_gui) : GUIElement(_gui,GUI_LAYER_BACKGROUND,0,0,640,TOP_PANEL_HEIGHT,"TopPanel") constructor
{
	align_top_to_parent = true;
	align_left_to_parent = true;
	align_right_to_parent = true;
	
	hoverable = false;
	set_parent_element(gui.canvas);
	
	static draw = function()
	{
		draw_set_colour(COLOUR.DARKEST_BROWN);
		draw_rectangle(x,y,x+width-1,y+height-1,false);
		draw_set_color(COLOUR.DARK_BROWN);
		draw_rectangle(x,y+height-3,x+width-1,y+height-1,false);
	}
}