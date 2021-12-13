#macro GUI_LAYER_RESOURCE_ICONS 0
#macro GUI_RESOURCE_INDICATOR_WIDTH 27
#macro GUI_RESOURCE_INDICATOR_HEIGHT 38 
/// @function GUIResourceIndicator
/// @param gui
/// @param x
/// @param y
/// @param resource
/// @param amount
function GUIResourceIndicator(_gui, _x, _y, _resource, _amount) : GUIElement(_gui,GUI_LAYER_RESOURCE_ICONS,_x,_y, GUI_RESOURCE_INDICATOR_WIDTH, GUI_RESOURCE_INDICATOR_HEIGHT,"ResourceIndicator") constructor
{
	resource = _resource;
	amount = _amount;
	
	colour = resource_get_colour(resource);
	bg_colour = resource_get_background_colour(resource);
	
	icon_x = (width-sprite_get_width(SprResourceIcons)) div 2;
	icon_y = icon_x;
	
	text_x = (width+1) div 2;
	text_y = (height*3) div 4 + 2;
	
	
	static draw = function()
	{
		//Frame
		draw_cornered_rectangle(x,y,x+width-1,y+height-1,colour,SprCornerRounded2Px);
		draw_cornered_rectangle(x+2,y+2,x+width-3,y+height-3,bg_colour,SprCornerRounded2Px);
		
		//Icon
		gpu_set_fog(true,colour,0,0);
		draw_sprite(SprResourceIcons,resource,x+icon_x,y+icon_y);
		gpu_set_fog(false,colour,0,0);
		
		//Text
		draw_set_color(colour);
		draw_set_font(FontVector7);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		var _amount_string = string(amount div 10) + string(amount mod 10);
		draw_text(x+text_x,y+text_y,_amount_string);
	}
}