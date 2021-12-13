/// @function GUIButton
/// @param gui
/// @param depth
/// @param x
/// @param y
/// @param width
/// @param height
/// @param text
function GUIButton(_gui, _depth, _x, _y, _width, _height, _text) : GUIElement(_gui, _depth, _x, _y, _width, _height, "Button") constructor
{
	text = _text;
	
	static draw = function()
	{
		draw_cornered_rectangle(x,y,x+width-1,y+height-1,COLOUR.LAVENDAR,SprCornerRounded2Px);
		var _colour = COLOUR.DARKEST_BLUE;
		if(is_hovered())
			_colour = COLOUR.DARK_LAVENDAR;
		draw_cornered_rectangle(x+3,y+3,x+width-1-3,y+height-1-3,_colour,SprCornerRounded2Px);
		
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_font(FontVector7);
		draw_text(x+width div 2, y+(height-7) div 2, text);
	}
}