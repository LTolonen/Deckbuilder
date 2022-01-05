/// @function GUIScaledCanvas
/// @param gui
/// @param target_width
/// @param target_height
function GUIScaledCanvas(_gui, _target_width, _target_height) : GUIElement(_gui,9999999,0,0,_target_width,_target_height,"ScaledCanvas") constructor
{
	gui = _gui;
	target_width = _target_width;
	target_height = _target_height;
	
	hoverable = false;
	view_index = 0;
	scale_factor = 1;
	forced_scale_factor = -1;

	fit_to_window();
	view_set_visible(view_index,true);

	/// @function fit_to_window
	static fit_to_window = function()
	{
		if(window_get_width() <= 0)
			return;
		if(forced_scale_factor == -1)
		{
			var _width_factor = window_get_width() div target_width;
			var _height_factor = window_get_height() div target_height;
			scale_factor = max(1,min(_width_factor,_height_factor));
		}
		else
		{
			scale_factor = forced_scale_factor;	
		}
		
		width = window_get_width() div scale_factor;
		height = window_get_height() div scale_factor;
		camera_set_view_size(view_camera[view_index],width,height);
		view_set_wport(view_index,window_get_width());
		view_set_hport(view_index,window_get_height());
		var _num_children = array_length(children);
		for(var i=0; i<_num_children; i++)
		{
			children[i].fit_to_parent_element();
		}
	}
}