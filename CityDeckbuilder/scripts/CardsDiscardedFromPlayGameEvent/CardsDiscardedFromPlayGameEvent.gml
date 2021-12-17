/// @function CardsDiscardedFromPlayGameEvent
function CardsDiscardedFromPlayGameEvent() : GameEvent(GAME_EVENT_TYPE.CARDS_DISCARDED_FROM_PLAY) constructor
{
	static toString = function()
	{
		return "Cards discarded from play";	
	}
}