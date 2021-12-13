/// @function Entity
/// @param entity_set
/// @param entity_type
function Entity(_entity_set, _entity_type) constructor
{
	entity_id = -1;
	if(_entity_set != -1)
		_entity_set.entity_set_add_entity(self);
	entity_type = _entity_type;
	
	/// @function entity_destroy
	static entity_destroy = function()
	{
		if(entity_set != -1)
			entity_set.entity_set_remove_entity(entity_id);	
	}
}