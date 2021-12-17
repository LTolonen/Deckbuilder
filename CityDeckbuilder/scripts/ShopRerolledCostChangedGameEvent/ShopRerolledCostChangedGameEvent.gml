/// @function ShopRerollCostChangedGameEvent
/// @param reroll_cost
function ShopRerollCostChangedGameEvent(_reroll_cost) : GameEvent(GAME_EVENT_TYPE.SHOP_REROLL_COST_CHANGED) constructor
{
	reroll_cost = _reroll_cost;
	
	static toString = function()
	{
		return "Shop reroll cost changed to "+string(reroll_cost);	
	}
}