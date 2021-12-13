function ShuffleGameEvent() : GameEvent(GAME_EVENT_TYPE.SHUFFLE) constructor
{
	static toString = function()
	{
		return "Discard pile shuffled into draw pile";	
	}
}