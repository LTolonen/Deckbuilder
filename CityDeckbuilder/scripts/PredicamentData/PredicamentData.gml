/// @function PredicamentData
/// @param name
/// @param turns
function PredicamentData(_name, _turns) constructor
{
	name = _name;
	turns = _turns;
	resource_requirement_curves = array_create(RESOURCE.COUNT,-1);
	
	/// @function predicament_data_set_resource_requirement_curve
	static predicament_data_set_resource_requirement_curve = function(_resource, _requirement_curve)
	{
		resource_requirement_curves[_resource] = _requirement_curve;
	}
	
	/// @function predicament_data_evaluate_resource_requirements
	/// @param level
	static predicament_data_evaluate_resource_requirements = function(_level)
	{
		var _resource_requirements = array_create(RESOURCE.COUNT,0);
		for(var i=0; i<RESOURCE.COUNT; i++)
		{
			if(resource_requirement_curves[i] == -1)
				continue;
			_resource_requirements[i] = resource_requirement_curves[i](_level);
		}
		return _resource_requirements;
	}
}