/// @function EntitySet
/// @param [initial_capacity]
function EntitySet(_initial_capacity) constructor
{
	next_id = 0;
	num_entities = 0;
	if(is_undefined(_initial_capacity))
		_initial_capacity = 256;
	entities = array_create(_initial_capacity,-1);
	
	/// @function entity_set_add_entity
	/// @param entity
	static entity_set_add_entity = function(_entity)
	{
		var _id = next_id;
		entities[_id] = _entity;
		_entity.entity_set = self;
		_entity.entity_id = _id;
		num_entities++;
		next_id++;
		return _id;
	}
	
	/// @function entity_set_add_entity_with_id
	/// @param entity
	/// @param id
	static entity_set_add_entity_with_id = function(_entity, _id)
	{
		if(entities[_id] != -1)
			throw "Attempted to add entity to IDSet with ID "+string(_id)+" when that ID is already in use";
		entities[_id] = _entity;
		_entity.entity_id = _id;
		_entity.entity_set = self;
		if(_id >= next_id)
			next_id = _id+1;
		num_entities++;
		return _id;
	}
	
	/// @function entity_set_remove_entity
	/// @param id
	static entity_set_remove_entity = function(_id)
	{
		if(entities[_id] == -1)
			return -1;
		var _entity = entities[_id];
		entities[_id] = -1;
		num_entities--;
		return _entity;
	}
	
	/// @function entity_set_get_entity
	/// @param id
	static entity_set_get_entity = function(_id)
	{
		return entities[_id];
	}
}