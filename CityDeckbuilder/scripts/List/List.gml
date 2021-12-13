function List() constructor
{
	num_items = 0;
	items = array_create(0);
	
	/// @function add_item
	/// @param item
	static add_item = function(_item)
	{
		items[num_items++] = _item;	
	}
	
	/// @function remove_item_at_index
	/// @param index
	static remove_item_at_index = function(_index)
	{
		array_delete(items,_index,1);
		num_items--;
	}
	
	/// @function pop_first_item
	static pop_first_item = function()
	{
		if(num_items == 0)
			throw "Popping first item from empty list";
			
		var _item = items[0];
		remove_item_at_index(0);
		return _item;
	}
	
	/// @function pop_last_item
	static pop_last_item = function()
	{
		if(num_items == 0)
			throw "Popping last item from empty list";
			
		var _item = items[num_items-1];
		remove_item_at_index(num_items-1);
		return _item;
	}

	/// @function empty_list
	static empty_list = function()
	{
		num_items = 0;
		items = array_create(0);
	}
	
	/// @function shuffle_list
	static shuffle_list = function()
	{
		// Knuth Fisher-Yates shuffle
		for(var i=num_items-1; i>=0; i--)
		{
			var j = irandom_range(0,i);
			var _temp = items[i];
			items[i] = items[j];
			items[j] = _temp;
		}
	}
}