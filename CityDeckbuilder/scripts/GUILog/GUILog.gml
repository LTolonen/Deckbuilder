/// @function GUILog
/// @param gui
/// @param x
/// @param y
function GUILog(_gui, _x, _y) : GUIElement(_gui,-1000,_x,_y,400,360,"Log") constructor
{
	log = new List();
	hoverable = false;
	
	static draw = function()
	{
		if(!global.DEBUG)
			return;
		draw_set_halign(fa_right);
		draw_set_valign(fa_top);
		draw_set_font(FontVector7);
		var y_offset = 2;
		for(var i=0; i<log.num_items; i++)
		{
			draw_set_color(c_black);
			draw_text_ext(x+width-5+1,y+y_offset+1,log.items[i],8,width-10);
			draw_set_color(c_yellow);
			draw_text_ext(x+width-5,y+y_offset,log.items[i],8,width-10);
			y_offset += string_height_ext(log.items[i],8,width-10);
		}
	}
	
	/// @function gui_log_add_line
	/// @param _line
	static gui_log_add_line = function(_line)
	{
		log.add_item(_line)
		if(log.num_items >= 30)
		{
			log.remove_item_at_index(0);
		}
	}
}