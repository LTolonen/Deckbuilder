/// @function draw_cornered_rectangle
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param colour
/// @param corner_sprite
function draw_cornered_rectangle (_x1, _y1, _x2, _y2, _colour, _corner_sprite)
{
	var _corner_width = sprite_get_width(_corner_sprite);
	var _corner_height= sprite_get_height(_corner_sprite);

	draw_set_color(_colour);
	draw_rectangle(_x1+_corner_width,_y1,_x2-_corner_width,_y2,false);
	draw_rectangle(_x1,_y1+_corner_height,_x2,_y2-_corner_height,false);
	
	gpu_set_fog(true,_colour,0,0);
	draw_sprite(_corner_sprite,0,_x1,_y1);
	draw_sprite(_corner_sprite,1,_x2-_corner_width+1,_y1);
	draw_sprite(_corner_sprite,2,_x1,_y2-_corner_height+1);
	draw_sprite(_corner_sprite,3,_x2-_corner_width+1,_y2-_corner_height+1);
	gpu_set_fog(false,c_white,0,0);
}