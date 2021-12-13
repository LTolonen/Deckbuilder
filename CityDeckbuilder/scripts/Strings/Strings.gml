/// @function string_split
/// @param str
/// @param split_char
function string_split(_str, _split_char)
{
	var _length = string_length(_str);
	var _split_string;
	var _num_items = 0;
	var _from_position = 1;
	for(var _to_position=1; _to_position<=_length; _to_position++)
	{
		if(_to_position == _length || string_char_at(_str,_to_position+1) == _split_char)
		{
			if(_from_position > _to_position)
				_split_string[_num_items++] = "";
			else
				_split_string[_num_items++] = string_copy(_str,_from_position,_to_position-_from_position+1);
			_from_position = _to_position+2;
		}
	}
	return _split_string;
}