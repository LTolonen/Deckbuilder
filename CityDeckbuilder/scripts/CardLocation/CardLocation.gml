enum ZONE
{
	NONE,
	SHOP,
	HAND,
	DRAW_PILE,
	DISCARD_PILE,
	PLAY
}

/// @function CardLocation
/// @param zone
/// @param position
function CardLocation(_zone, _position) constructor
{
	zone = _zone;
	position = _position;
}