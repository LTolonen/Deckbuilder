enum RESOURCE
{
	HEALTH = 0,
	WORKERS = 1,
	MONEY = 2,
	POWER = 3,
	FOOD = 4,
	COUNT
}

global.RESOURCE_COLOURS = [COLOUR.RED,COLOUR.BLUE,COLOUR.ORANGE, COLOUR.LAVENDAR, COLOUR.GREEN];
global.RESOURCE_BACKGROUND_COLOURS = [COLOUR.DARKEST_RED,COLOUR.DARKEST_BLUE,COLOUR.DARKEST_ORANGE,COLOUR.DARKEST_BLUE,COLOUR.DARKEST_GREEN];
global.RESOURCE_NAMES = ["Health", "WORKERS", "Money", "Power", "Food"];
global.RESOURCE_TOKEN_STRINGS = ["{H}","{W}","{M}","{P}","{F}"];

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

/// @function resource_get_token_string
/// @param resource
function resource_get_token_string(_resource)
{
	return global.RESOURCE_TOKEN_STRINGS[_resource];	
}