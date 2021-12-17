#macro GUI_LAYER_PREDICAMENT -100
#macro GUI_PREDICAMENT_WIDTH 160
#macro GUI_PREDICAMENT_HEIGHT 100
#macro GUI_PREDICAMENT_HEADER_HEIGHT 13
#macro GUI_PREDICAMENT_ART_BOX_HEIGHT 40
#macro GUI_PREDICAMENT_TEXT_BORDER 3

/// @function GUIPredicament
/// @param gui
/// @param x
/// @param y
/// @param predicament_data
function GUIPredicament(_gui, _x, _y, _predicament_data) : GUIElement(_gui,GUI_LAYER_PREDICAMENT,_x,_y,GUI_PREDICAMENT_WIDTH,GUI_PREDICAMENT_HEIGHT,"Predicament") constructor
{
	predicament_data = _predicament_data;
	remaining_turns = _predicament_data.turns;
	
	text_width = width-4*GUI_PREDICAMENT_TEXT_BORDER;
	text_height = height-GUI_PREDICAMENT_HEADER_HEIGHT-GUI_PREDICAMENT_ART_BOX_HEIGHT-2*GUI_PREDICAMENT_TEXT_BORDER;
	
	var _requirement_string = "Requirements: \n ";
	var n = 0;
	for(var i=0; i<RESOURCE.COUNT; i++)
	{
		if(predicament_data.resource_requirements[i] == 0)
			continue;
		if(n > 0)
			_requirement_string += " | ";
		_requirement_string += string(predicament_data.resource_requirements[i])+" "+resource_get_token_string(i);
		n++;
	}
	var _tokens = string_tokenise(_requirement_string,FontVector7);
	text_fitting = new TokenisedTextFitting(_tokens,width-4*GUI_PREDICAMENT_TEXT_BORDER,height-4*GUI_PREDICAMENT_TEXT_BORDER,4,17);
	
	colour = COLOUR.BROWN;
	bg_colour = COLOUR.DARKEST_BROWN;
	
	static draw = function()
	{
		//Frame
		draw_cornered_rectangle(x,y,x+width-1,y+height-1,colour,SprCornerRounded2Px);
		draw_set_color(COLOUR.BLUE_BLACK);
		draw_rectangle(x,y+GUI_PREDICAMENT_HEADER_HEIGHT,x+width-1,y+GUI_PREDICAMENT_HEADER_HEIGHT+GUI_PREDICAMENT_ART_BOX_HEIGHT-1,false);
		draw_cornered_rectangle(x+GUI_PREDICAMENT_TEXT_BORDER,y+GUI_PREDICAMENT_HEADER_HEIGHT+GUI_PREDICAMENT_ART_BOX_HEIGHT+GUI_PREDICAMENT_TEXT_BORDER,x+width-1-GUI_PREDICAMENT_TEXT_BORDER,y+height-1-GUI_PREDICAMENT_TEXT_BORDER,bg_colour,SprCornerRounded2Px);
		
		//Name
		draw_set_color(bg_colour);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_font(FontVector7);
		draw_text(x+width div 2 + 1,y+(GUI_PREDICAMENT_HEADER_HEIGHT-7) div 2 + 1,predicament_data.name);
		draw_set_color(COLOUR.WHITE);
		draw_text(x+width div 2,y+(GUI_PREDICAMENT_HEADER_HEIGHT-7) div 2,predicament_data.name);
		
		//Text Box
		draw_tokenised_text(x+width div 2,y+GUI_PREDICAMENT_HEADER_HEIGHT+GUI_PREDICAMENT_ART_BOX_HEIGHT+GUI_PREDICAMENT_TEXT_BORDER+text_height div 2,text_fitting,fa_center,fa_middle);
		
		//Buy Cost
		draw_set_color(COLOUR.WHITE);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_font(FontVector7);
		draw_text(x+width div 2, y+height+4,string(remaining_turns) + " turns remaining");
	}
}