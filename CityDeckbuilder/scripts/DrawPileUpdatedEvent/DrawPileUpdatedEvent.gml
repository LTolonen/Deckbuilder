/// @function DrawPileUpdatedGameEvent
/// @param draw_pile_list
function DrawPileUpdatedGameEvent(_draw_pile_list) : GameEvent(GAME_EVENT_TYPE.DRAW_PILE_UPDATED) constructor
{
	draw_pile_list = _draw_pile_list
	
	static toString = function()
	{
		return "Draw Pile updated ("+string(draw_pile_list.num_items)+" cards)";	
	}
}