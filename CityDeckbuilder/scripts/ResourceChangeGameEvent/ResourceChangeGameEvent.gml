/// @function ResourceChangeGameEvent
/// @param resource
/// @param new_amount
/// @param delta_amount
function ResourceChangeGameEvent(_resource, _new_amount, _change_amount) : GameEvent(GAME_EVENT_TYPE.RESOURCE_CHANGE) constructor
{
	resource = _resource;
	new_amount = _new_amount;
	change_amount = _change_amount;
	
	static toString = function()
	{
		return resource_get_name(resource)+" resource changed from "+string(new_amount-change_amount)+" to "+string(new_amount)+" ("+(change_amount > 0?"+":"")+string(change_amount)+")";
	}
}