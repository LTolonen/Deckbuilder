/// @function DiscardPileUpdatedGameEvent
/// @param discard_pile_list
function DiscardPileUpdatedGameEvent(_discard_pile_list) : GameEvent(GAME_EVENT_TYPE.DISCARD_PILE_UPDATED) constructor
{
	discard_pile_list = _discard_pile_list
	
	static toString = function()
	{
		return "Discard Pile updated ("+string(discard_pile_list.num_items)+" cards)";	
	}
}