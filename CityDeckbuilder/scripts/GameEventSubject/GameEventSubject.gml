function GameEventSubject()
{
	observers = new Collection();
	
	/// @function game_event_subject_add_observer
	/// @param observer
	static game_event_subject_add_observer = function(_observer)
	{
		observers.collection_add(_observer);
	}
	
	/// @function game_event_subject_remove_observer
	/// @param observer
	static game_event_subject_remove_observer = function(_observer)
	{
		observers.collection_remove(_observer);
	}
	
	/// @function game_event_subject_notify
	/// @param event
	static game_event_subject_notify = function(_event)
	{
		for(var i=0; i<observers.num_items; i++)
		{
			observers.items[i].on_notify(_event);	
		}
	}
}