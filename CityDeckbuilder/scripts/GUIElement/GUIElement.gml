/// @function GUIElement
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
/// @param gui_element_type
function GUIElement(_gui, _depth, _x, _y, _width, _height, _gui_element_type) constructor
{
	gui = _gui;
	depth = _depth;
	x = _x;
	y = _y;
	width = _width;
	height = _height;
	gui_element_type = _gui_element_type;
	
	active = true;
	visible = true;
	padding = 0;
	hoverable = true;
	selectable = true;
	
	align_left_to_parent = false;
	align_right_to_parent = false;
	align_top_to_parent = false;
	align_bottom_to_parent = false;
	
	parent_element = -1;
	children = array_create(0);
	
	gui.add_gui_element(self);
	
	static draw = -1;
	static update = -1;
	static cleanup = -1;
	static on_enter_gui_state = -1;
	static on_click = -1;
	static on_click_down = -1;
	static on_hover = -1;
	static on_unhover = -1;
	static on_deselect = -1;
	
	static destroy = function()
	{
		if(cleanup != -1)
			cleanup();
		
		if(parent_element != -1)
		{
			//Remove this element from its parent's list of children
			var _num_children =  array_length(parent_element.children);
			for(var i=0; i<_num_children; i++)
			{
				if(parent_element.children[i] == self)
				{
					array_delete(parent_element.children,i,1);
					break;
				}
			}
		}
		//Destroy all the child elements
		while(array_length(children) > 0)
		{
			children[0].destroy();	
		}
		
		gui.remove_gui_element(self);
	}
	
	///@function set_parent_element
	static set_parent_element = function(_gui_element)
	{
		//If equal to the current parent, no change is required.
		if(parent_element == _gui_element)
			return;
		//Remove this element from the child list of its old parent.
		if(parent_element != -1)
		{
			var _num_children =  array_length(parent_element.children);
			for(var i=0; i<_num_children; i++)
			{
				if(parent_element.children[i] == self)
				{
					array_delete(parent_element.children,i,1);
					break;
				}
			}
		}
		
		//Update the parent and add to the child list of the new parent.
		parent_element = _gui_element;
		if(parent_element != -1)
		{
			var _num_children =  array_length(parent_element.children);
			parent_element.children[_num_children] = self;
		}
	}
	
	/// @function set_depth
	/// @param depth
	static set_depth = function(_depth)
	{
		if(_depth == depth)
			return;
		depth = _depth;
		gui.remove_gui_element(self);
		gui.add_gui_element(self);
	}
	
	///@function move_by
	///@param dx
	///@param dy
	static move_by = function(_dx, _dy)
	{
		if(_dx == 0 && _dy == 0)
			return;
		x += _dx;
		y += _dy;
		var _num_children = array_length(children);
		for(var i=0; i<_num_children; i++)
		{
			children[i].move_by(_dx,_dy);
		}
	}
	
	///@function move_to
	///@param x
	///@param y
	static move_to = function(_x,_y)
	{
		move_by(_x-x,_y-y);
	}
	
	/// @function fit_to_parent_element
	static fit_to_parent_element = function()
	{
		if(parent_element == -1)
			return;
		var _new_x = x;
		var _new_y = y;
		var _new_width = width;
		var _new_height = height;
		
		if(align_left_to_parent)
		{
			_new_x = parent_element.x;
			if(align_right_to_parent)
			{
				_new_width = parent_element.width;
			}
		}
		else if(align_right_to_parent)
		{
			_new_x = parent_element.x + parent_element.width - width;	
		}
		
		if(align_top_to_parent)
		{
			_new_y = parent_element.y;
			if(align_bottom_to_parent)
			{
				_new_height = parent_element.height;
			}
		}
		else if(align_bottom_to_parent)
		{
			_new_y = parent_element.y + parent_element.height - height;	
		}
		
		var _position_updated = x != _new_x || y != _new_y;
		var _size_updated = width != _new_width || height != _new_height;
		if(_position_updated)
		{
			move_to(_new_x,_new_y);	
		}
		if(_size_updated)
		{
			width = _new_width;
			height = _new_height;
			var _num_children = array_length(children);
			for(var i=0; i<_num_children; i++)
			{
				children[i].fit_to_parent_element();
			}
		}
	}
	
	/// @function is_hovered
	static is_hovered = function()
	{
		return (gui.hover_element == self);	
	}
	
	/// @function is_selected
	static is_selected = function()
	{
		return (gui.selected_element == self);	
	}
}