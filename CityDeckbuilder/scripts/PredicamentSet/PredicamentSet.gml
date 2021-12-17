function PredicamentSet() constructor
{
	num_predicaments = 0;
	predicaments = array_create(0);
	
	/// @function predicament_set_add_predicament
	/// @param predicament_data
	static predicament_set_add_predicament = function(_predicament_data)
	{
		predicaments[num_predicaments++] = _predicament_data;
	}
	
	/// @function predicament_set_choose_event
	static predicament_set_choose_predicament = function()
	{
		return predicaments[irandom(num_predicaments-1)];	
	}
}

function predicament_set_init()
{
	predicament_set = new PredicamentSet();
	
	var _predicament_data;

	_predicament_data = new PredicamentData("Invasion",5);
	_predicament_data.predicament_data_set_resource_requirement(RESOURCE.POWER,10);
	predicament_set.predicament_set_add_predicament(_predicament_data);
	
	_predicament_data = new PredicamentData("Famine",5);
	_predicament_data.predicament_data_set_resource_requirement(RESOURCE.FOOD,10);
	predicament_set.predicament_set_add_predicament(_predicament_data);

	_predicament_data = new PredicamentData("Taxation",5);
	_predicament_data.predicament_data_set_resource_requirement(RESOURCE.MONEY,10);
	predicament_set.predicament_set_add_predicament(_predicament_data);
	
	return predicament_set;
}