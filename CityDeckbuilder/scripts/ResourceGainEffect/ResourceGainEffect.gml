/// @function ResourceGainEffect
/// @param resource
/// @param amount
function ResourceGainEffect(_resource, _amount) constructor
{
	resource = _resource;
	amount = _amount;
	
	static effect_perform = function(_game_state)
	{
		_game_state.game_change_resource(resource,amount);	
	}
}