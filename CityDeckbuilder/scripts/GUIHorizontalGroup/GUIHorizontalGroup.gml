enum ALIGNMENT_HORIZONTAL
{
	LEFT,
	CENTER,
	RIGHT
}

/// @function GUIHorizontalGroup
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
function GUIHorizontalGroup(_gui, _depth, _x, _y, _width, _height) : GUIElement(_gui, _depth, _x, _y, _width, _height, "HorizontalGroup") constructor
{
	hoverable = false;
	horizontal_alignment = ALIGNMENT_HORIZONTAL.LEFT;
	padding = 0;
	separation = 0;
	
	fixed_width_total = 0;
	weighted_width_total = 0;
	
	on_resize = gui_group_align_items;

	static gui_group_align_items = function()
	{
		var _num_items = array_length(children);
		var _remaining_width = width-2*padding-separation*(_num_items-1)-fixed_width_total;
		var _total_width = padding;
		for(var i=0; i<_num_items; i++)
		{
			var _item = children[i];
			_item.x = x+_total_width;
			_item.y = y;
			if(!_item.fixed_width)
			{
				var w = _remaining_width * _item.weighted_width / weighted_width_total;	
				_item.resize(w,_item.height);
			}
			_total_width += _item.width+separation;
		}
		if(horizontal_alignment != ALIGNMENT_HORIZONTAL.LEFT)
		{
			var _offset;
			if(horizontal_alignment == ALIGNMENT_HORIZONTAL.CENTER)
			{
				_offset = (width-_total_width) div 2;
			}
			else if(horizontal_alignment == ALIGNMENT_HORIZONTAL.RIGHT)
			{
				_offset = width-_total_width;
			}
			if(_offset != 0)
			{
				for(var i=0; i<_num_items; i++)
				{
					var _item = children[i];
					_item.move_by(_offset,0);
				}
			}
		}
	}
	
	static gui_group_add_item = function(_item)
	{
		_item.set_parent_element(self);
		if(_item.fixed_width)
		{
			fixed_width_total += _item.width;	
		}
		else
		{
			weighted_width_total += _item.weighted_width;
		}
	}
}