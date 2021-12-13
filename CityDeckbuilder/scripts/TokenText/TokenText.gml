/// @function draw_tokenised_text
/// @param x
/// @param y
/// @param tokenised_text_fitting
/// @param halign
/// @param valign
function draw_tokenised_text(_x,_y,_tokenised_text_fitting, _halign, _valign)
{
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var _font_height = 7
	var _text_y_offset = (_tokenised_text_fitting.row_height-_font_height) div 2;
	for(var i=0; i<_tokenised_text_fitting.num_rows; i++)
	{
		var _row = _tokenised_text_fitting.rows[i];
		var _row_x = 0;
		if(_halign == fa_center)
		{
			_row_x = -_row.width div 2;	
		}
		else if(_halign == fa_right)
		{
			_row_x = -_row.width;	
		}
		var _row_y = i*_tokenised_text_fitting.row_height;
		if(_valign == fa_middle)
		{
			_row_y -= _tokenised_text_fitting.row_height*_tokenised_text_fitting.num_rows div 2;	
		}
		else
		{
			_row_y -= _tokenised_text_fitting.row_height*_tokenised_text_fitting.num_rows;
		}
		draw_set_color(COLOUR.WHITE);
		var _x_offset = 0;
		for(var j=0; j<_row.num_tokens; j++)
		{
			var _token = _row.tokens[j];
			switch(_token.token_type)
			{
				case TOKEN_TYPE.TEXT:
					draw_text(_x+_row_x+_x_offset,_y+_row_y+_text_y_offset,_token.text);
					break;
				case TOKEN_TYPE.SPRITE:
					gpu_set_fog(true,_token.colour,0,0);
					draw_sprite(_token.sprite_index,_token.image_index,_x+_row_x+_x_offset,_y+_row_y);
					gpu_set_fog(false,_token.colour,0,0);
					break;
			}
			_x_offset += _token.width;
		}
	}
}

/// @function string_tokenise
/// @param text
/// @param font
function string_tokenise(_text, _font)
{
	var _split_string = string_split(_text," ");
	var _num_tokens = array_length(_split_string);
	var _tokens = array_create(_num_tokens,-1);
	for(var i=0; i<_num_tokens; i++)
	{
		switch(_split_string[i])
		{
			case "{H}":
				_tokens[i] = new SpriteToken(SprResourceIcons,RESOURCE.HEALTH,resource_get_colour(RESOURCE.HEALTH));
				break;
			case "{E}":
				_tokens[i] = new SpriteToken(SprResourceIcons,RESOURCE.ENERGY,resource_get_colour(RESOURCE.ENERGY));
				break;
			case "{M}":
				_tokens[i] = new SpriteToken(SprResourceIcons,RESOURCE.MONEY,resource_get_colour(RESOURCE.MONEY));
				break;
			case "{P}":
				_tokens[i] = new SpriteToken(SprResourceIcons,RESOURCE.POWER,resource_get_colour(RESOURCE.POWER));
				break;
			case "{F}":
				_tokens[i] = new SpriteToken(SprResourceIcons,RESOURCE.FOOD,resource_get_colour(RESOURCE.FOOD));
				break;
			case "\n":
				_tokens[i] = new NewLineToken();
				break;
			default:
				_tokens[i] = new TextToken(_split_string[i],_font);
		}
	}
	return _tokens;
}


enum TOKEN_TYPE
{
	TEXT,
	SPRITE,
	SPACE,
	NEW_LINE
}
/// @function SpriteToken
/// @param sprite_index
/// @param image_index
/// @param colour
function SpriteToken(_sprite_index, _image_index, _colour) constructor
{
	token_type = TOKEN_TYPE.SPRITE;
	sprite_index = _sprite_index;
	image_index = _image_index;
	colour = _colour;
	
	width = sprite_get_width(sprite_index);
}

/// @function TextToken
/// @param text
/// @param font
function TextToken(_text, _font) constructor
{
	token_type = TOKEN_TYPE.TEXT;
	text = _text;
	font = _font;
	
	draw_set_font(_font);
	width = string_width(text);
}

/// @function SpaceToken
function SpaceToken(_width) constructor
{
	token_type = TOKEN_TYPE.SPACE;
	width = _width;
}

/// @function NewLineToken
function NewLineToken() constructor
{
	token_type = TOKEN_TYPE.NEW_LINE;
	width = 0;
}

/// @function TokenisedTextFitting
/// @param tokens
/// @param max_width
/// @param max_height
/// @param space_width
/// @param row_height
function TokenisedTextFitting(_tokens, _max_width, _max_height, _space_width, _row_height) constructor
{
	max_width = _max_width;
	max_height = _max_height;
	space_width = _space_width;
	row_height = _row_height;
	num_rows = 1;
	rows[0] = new TextRow(max_width,space_width);
	for(var i=0; i<array_length(_tokens); i++)
	{
		var _token = _tokens[i];
		var _row = rows[num_rows-1];
		if(_token.token_type == TOKEN_TYPE.NEW_LINE)
		{
			if((num_rows+1)*row_height <= max_height)
			{
				_row = new TextRow(max_width,space_width);
				rows[num_rows++] = _row;
			}
			else
			{
				_row.tokens[_row.num_tokens-1] = new TextToken("...",FontVector7);
				break;	
			}
		}
		else if(_row.text_row_can_add_token(_token))
		{
			_row.text_row_add_token(_token);
		}
		else
		{
			if((num_rows+1)*row_height <= max_height)
			{
				_row = new TextRow(max_width,space_width);
				rows[num_rows++] =  _row;
				_row.text_row_add_token(_token);
			}
			else
			{
				_row.tokens[_row.num_tokens-1] = new TextToken("...",FontVector7);
				break;	
			}
		}
	}
}

/// @function TextRow
/// @param max_width
/// @param space_width
function TextRow(_max_width, _space_width) constructor
{
	max_width = _max_width;
	space_width = _space_width;
	
	width = 0;
	num_tokens = 0;
	tokens = array_create(0);
	last_token_type = -1;
	
	/// @function text_row_add_token
	/// @param token
	static text_row_add_token = function(_token)
	{
		if(_token.token_type == TOKEN_TYPE.TEXT && last_token_type == TOKEN_TYPE.TEXT)
		{
			tokens[num_tokens++] = new SpaceToken(space_width);
			width += space_width;
		}
		tokens[num_tokens++] = _token;
		width += _token.width;
		last_token_type = _token.token_type;
	}
	
	/// @function text_row_can_add_token
	/// @param token
	static text_row_can_add_token = function(_token)
	{
		var w = 0;
		if(_token.token_type == TOKEN_TYPE.TEXT && last_token_type == TOKEN_TYPE.TEXT)
		{
			w += space_width;
		}
		return width+_token.width+w <= max_width;
	}
}