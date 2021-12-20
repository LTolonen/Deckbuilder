/// @function Predicament
/// @param predicament_data
/// @param level
function Predicament(_predicament_data, _level) constructor
{
	predicament_data = _predicament_data;
	level = _level;
	
	turns_remaining = _predicament_data.turns;
	resource_requirements = predicament_data.predicament_data_evaluate_resource_requirements(level);
}