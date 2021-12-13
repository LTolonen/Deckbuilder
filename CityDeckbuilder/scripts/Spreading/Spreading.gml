/// @function spread_item
/// @param size
/// @param num_items
/// @param item_size
/// @param item_index
function spread_item(_size,_num_items,_item_size,_item_index)
{
	var _remaining_space = _size - (_item_size * _num_items);
	var _separation = _remaining_space / (_num_items+1);
	return _separation * (_item_index + 1) + _item_size * _item_index;
}

/// @function spread_item_centered
/// @param size
/// @param num_items
/// @param item_size
/// @param item_index
function spread_item_centered(_size,_num_items,_item_size,_item_index)
{
	var _remaining_space = _size - (_item_size * _num_items);
	var _separation = _remaining_space / (_num_items+1);
	return _separation * (_item_index + 1) + _item_size * _item_index;
}