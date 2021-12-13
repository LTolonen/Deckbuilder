/// @function Collection
function Collection() constructor
{
	num_items = 0;
	items = array_create(0);
	
	/// @function collection_contains
	/// @param item
	static collection_contains = function(_item)
	{
		for(var i=0; i<num_items; i++)
		{
			if(items[i] == _item)
				return true;
		}
		return false;
	}
	
	/// @function collection_add
	/// @param item
	static collection_add = function(_item)
	{
		if(!collection_contains(_item))
		{
			items[num_items++] = _item;	
		}
	}

	/// @function collection_remove
	/// @param item
	static collection_remove = function(_item)
	{
		for(var i=num_items-1; i>=0; i--)
		{
			if(items[i] == _item)
			{
				collection_remove_at_index(i);
			}
		}
	}
	
	/// @function collection_remove_at_index
	/// @param index
	static collection_remove_at_index = function(_index)
	{
		array_delete(items,_index,1);
		num_items--;	
	}
}