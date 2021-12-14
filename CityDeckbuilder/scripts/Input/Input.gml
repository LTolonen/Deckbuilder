enum INPUT_TYPE
{
	TURN_END,
	PLAY_CARD,
	BUY_CARD,
	COUNT
}

/// @function Input
/// @param input_type
function Input(_input_type) constructor
{
	input_type = _input_type;
}