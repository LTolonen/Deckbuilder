enum RESOURCE
{
	HEALTH = 0,
	ENERGY = 1,
	MONEY = 2,
	POWER = 3,
	FOOD = 4,
	COUNT
}

global.RESOURCE_COLOURS = [COLOUR.RED,COLOUR.BLUE,COLOUR.ORANGE, COLOUR.LAVENDAR, COLOUR.GREEN];
global.RESOURCE_BACKGROUND_COLOURS = [COLOUR.DARKEST_RED,COLOUR.DARKEST_BLUE,COLOUR.DARKEST_ORANGE,COLOUR.DARKEST_BLUE,COLOUR.DARKEST_GREEN];
global.RESOURCE_NAMES = ["Health", "Energy", "Money", "Power", "Food"];

/// @function resource_get_colour
/// @param resource
function resource_get_colour(_resource)
{
	return 	global.RESOURCE_COLOURS[_resource];
}

/// @function resource_get_background_colour
/// @param resource
function resource_get_background_colour(_resource)
{
	return global.RESOURCE_BACKGROUND_COLOURS[_resource];	
}

/// @function resource_get_name
/// @param resource
function resource_get_name(_resource)
{
	return global.RESOURCE_NAMES[_resource];
}