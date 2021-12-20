function Pool() constructor
{
	list = new List();
	total_weight = 0;
	
	/// @function pool_add_item
	/// @param item
	/// @param weight
	static pool_add_item = function(_item, _weight)
	{
		list.add_item(
			{
				item: _item,
				weight: _weight
			}
		);
		total_weight += _weight;
	}
	
	/// @function pool_choose_item
	static pool_choose_item = function()
	{
		var _spin = irandom(total_weight);
		for(var i=0; i<list.num_items; i++)
		{
			_spin -= list.items[i].weight;
			if(_spin <= 0)
				return list.items[i].item;	
		}	
	}
}