enum CARD_FRAME_TYPE
{
	ACTION,
	ENERGY,
	MONEY,
	POWER,
	FOOD
}

/// @function CardData
/// @param name
/// @param buy_cost
/// @param energy_cost
/// @param strength 
/// @param text
/// @param frame_type
function CardData(_name, _buy_cost, _energy_cost, _strength, _text, _frame_type) constructor
{
	name = _name;
	buy_cost = _buy_cost;
	energy_cost = _energy_cost;
	strength = _strength;
	text = _text;
	text_tokenised = string_tokenise(_text,FontVector7);
	frame_type = _frame_type;
	
	is_playable = true;
	
	num_on_play_effects = 0;
	on_play_effects = array_create(0);
	
	/// @function card_data_add_effect
	/// @param effect
	static card_data_add_effect = function(_effect)
	{
		on_play_effects[num_on_play_effects++] = _effect;
	}
}

/// @function card_frame_type_get_colour
/// @param frame_type
function card_frame_type_get_colour(_frame_type)
{
	switch(_frame_type)	
	{
		case CARD_FRAME_TYPE.ACTION: return COLOUR.RED;	
		case CARD_FRAME_TYPE.ENERGY: return COLOUR.BLUE;
		case CARD_FRAME_TYPE.MONEY: return COLOUR.ORANGE;
		case CARD_FRAME_TYPE.POWER: return COLOUR.LAVENDAR;
		case CARD_FRAME_TYPE.FOOD: return COLOUR.GREEN;
		default:
			return COLOUR.BROWN;
	}
}

/// @function card_frame_type_get_background_colour
/// @param frame_type
function card_frame_type_get_background_colour(_frame_type)
{
	switch(_frame_type)	
	{
		case CARD_FRAME_TYPE.ACTION: return COLOUR.DARKEST_RED;	
		case CARD_FRAME_TYPE.ENERGY: return COLOUR.DARKEST_BLUE;
		case CARD_FRAME_TYPE.MONEY: return COLOUR.DARKEST_ORANGE;
		case CARD_FRAME_TYPE.POWER: return COLOUR.DARKEST_BLUE;
		case CARD_FRAME_TYPE.FOOD: return COLOUR.DARKEST_GREEN;
		default:
			return COLOUR.BROWN;
	}
}