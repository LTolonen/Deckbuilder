enum ALIGNMENT_VERTICAL
{
	TOP,
	MIDDLE,
	BOTTOM
}

/// @function GUIVerticalGroup
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
function GUIVerticalGroup(_gui, _depth, _x, _y, _width, _height) : GUIElement(_gui, _depth, _x, _y, _width, _height, "VerticalGroup") constructor
{
	hoverable = false;
	vertical_alignment = ALIGNMENT_VERTICAL.TOP;
	padding = 0;
	separation = 0;
	
	fixed_height_total = 0;
	weighted_height_total = 0;
	
	on_resize = gui_group_align_items;

	/// @function gui_group_align_items
	static gui_group_align_items = function()
	{
		var _num_items = array_length(children);
		var _remaining_height = height-2*padding-separation*(_num_items-1)-fixed_height_total;
		var _total_height = padding;
		for(var i=0; i<_num_items; i++)
		{
			var _item = children[i];
			_item.x = x;
			_item.y = y+_total_height;
			if(!_item.fixed_height)
			{
				var h = _remaining_height * _item.weighted_height / weighted_height_total;
				_item.resize(_item.width,h);
			}
			_total_height += _item.height+separation;
		}
		if(vertical_alignment != ALIGNMENT_VERTICAL.TOP)
		{
			var _offset;
			if(vertical_alignment == ALIGNMENT_VERTICAL.MIDDLE)
			{
				_offset = (height-_total_height) div 2;
			}
			else if(vertical_alignment == ALIGNMENT_VERTICAL.BOTTOM)
			{
				_offset = height-_total_height;
			}
			if(_offset != 0)
			{
				for(var i=0; i<_num_items; i++)
				{
					var _item = children[i];
					_item.move_by(0,_offset);
				}
			}
		}
	}
	
	/// @function gui_group_add_item
	/// @param item
	static gui_group_add_item = function(_item)
	{
		_item.set_parent_element(self);
		if(_item.fixed_height)
		{
			fixed_height_total += _item.height;	
		}
		else
		{
			weighted_height_total += _item.weighted_height;
		}
	}
}