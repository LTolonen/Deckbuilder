///@function GUIHorizontalGroupItem
/// @param gui
/// @param horizontal_group
/// @param depth
/// @param width
/// @param weighted_width
function GUIHorizontalGroupItem(_gui, _group, _depth, _width, _weighted_width) : GUIElement(_gui, _depth, 0, 0, _width, 0,"HorizontalGroupItem") constructor
{
	hoverable = false;
	align_top_to_parent = true;
	align_bottom_to_parent = true;
	
	group = _group;
	x = group.x;
	height = group.height;
	weighted_width = _weighted_width;
	fixed_width = (weighted_width <= 0);
	group.gui_group_add_item(self);
	
	static draw = function()
	{
		draw_rectangle(x,y,x+width-1,y+height-1,true);	
	}
}
