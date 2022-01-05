/// @function GUIVerticalGroupItem
/// @param gui
/// @param vertical_group
/// @param depth
/// @param height
/// @param weighted_height
function GUIVerticalGroupItem(_gui, _group, _depth, _height, _weighted_height) : GUIElement(_gui, _depth, 0, 0, 0, _height,"VerticalGroupItem") constructor
{
	hoverable = false;
	align_left_to_parent = true;
	align_right_to_parent = true;
	
	group = _group;
	y = group.y;
	width = group.width;
	weighted_height = _weighted_height;
	fixed_height = (weighted_height <= 0);
	group.gui_group_add_item(self);
	
	static draw = function()
	{
		draw_rectangle(x,y,x+width-1,y+height-1,true);	
	}
}
