/// @function PredicamentData
/// @param name
/// @param turns
function PredicamentData(_name, _turns) constructor
{
	name = _name;
	turns = _turns;
	resource_requirements = array_create(RESOURCE.COUNT,0);
	
	/// @function predicament_data_set_resource_requirement
	static predicament_data_set_resource_requirement = function(_resource, _cost)
	{
		resource_requirements[_resource] = _cost;	
	}
}