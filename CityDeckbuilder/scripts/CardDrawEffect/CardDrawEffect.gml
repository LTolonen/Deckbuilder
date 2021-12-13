/// @function CardDrawEffect
/// @param amount
function CardDrawEffect(_amount) constructor
{
	amount = _amount;
	
	static effect_perform = function(_game_state)
	{
		repeat(amount)
		{
			_game_state.game_draw_card();	
		}
	}
}