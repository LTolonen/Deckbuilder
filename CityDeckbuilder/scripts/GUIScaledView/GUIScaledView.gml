/// @function GUIScaledView
/// @param gui
/// @param target_width
/// @param target_height
function GUIScaledView(_gui, _target_width, _target_height) constructor
{
	gui = _gui;
	target_width = _target_width;
	target_height = _target_height;
	
	view_index = 0;
	view_width = target_width;
	view_height = target_height;
	scale_factor = 1;

	fit_to_window();
	view_set_visible(view_index,true);

	/// @function fit_to_window
	static fit_to_window = function()
	{
		if(window_get_width() <= 0)
			return;
		var _width_factor = window_get_width() div target_width;
		var _height_factor = window_get_height() div target_height;
		scale_factor = max(1,min(_width_factor,_height_factor));
		
		view_width = window_get_width() div scale_factor;
		view_height = window_get_height() div scale_factor;
		camera_set_view_size(view_camera[view_index],view_width,view_height);
		view_set_wport(view_index,window_get_width());
		view_set_hport(view_index,window_get_height());
		show_debug_message("Scale Factor: "+ string(scale_factor)+", Width: "+string(view_width)+", Height: "+string(view_height));
	}
}