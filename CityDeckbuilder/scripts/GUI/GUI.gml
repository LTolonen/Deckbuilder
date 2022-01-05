function GUI() constructor
{	
	window_width = window_get_width();
	window_height = window_get_height();
	view = new GUIScaledView(self,640,360);

	gui_elements = array_create();
	
	gui_state = new GUIState(self,GUI_STATE_TYPE.NONE);
	
	hover_element = -1;
	selected_element = -1;
	clicked_element = -1;
	
	on_resize = -1;
	
	/// @function add_gui_element
	/// @param gui_element
	static add_gui_element = function(_gui_element)
	{
		var _num_gui_elements = array_length(gui_elements);
		var _index = 0;
		for(var i=_num_gui_elements-1; i>=0; i--)
		{
			if(gui_elements[i].depth >= _gui_element.depth)
			{
				_index = i+1;
				break;
			}
		}
		array_insert(gui_elements,_index,_gui_element);
	}
	
	/// @function remove_gui_element
	/// @param gui_element
	static remove_gui_element = function(_gui_element)
	{
		var _num_gui_elements = array_length(gui_elements);
		for(var i=0; i<_num_gui_elements; i++)
		{
			if(gui_elements[i] == _gui_element)
			{
				array_delete(gui_elements,i,1);
				break;
			}
		}
	}
	
	/// @function draw
	static draw = function()
	{
		var _num_gui_elements = array_length(gui_elements);
		for(var i=0; i<_num_gui_elements; i++)
		{
			if(!gui_elements[i].active || !gui_elements[i].visible || gui_elements[i].draw == -1)
				continue;
			gui_elements[i].draw();	
		}
	}
	
	static update = function()
	{
		if(window_width != window_get_width() || window_height != window_get_height())
		{
			if(window_width > 0) //Check window isn't minimised
			{
				window_width = window_get_width();
				window_height = window_get_height();
				surface_resize(application_surface,window_width,window_height);
				view.fit_to_window();
				if(on_resize != -1)
					on_resize();
			}
		}
		if(gui_state.update != -1)
		{
			gui_state.update();
		}
	}
	
	/// @function update_elements = function()
	static update_elements = function()
	{
		var _num_gui_elements = array_length(gui_elements);
		var _gui_elements_to_update = array_create(_num_gui_elements,-1);
		array_copy(_gui_elements_to_update,0,gui_elements,0,_num_gui_elements);
		for(var i=0; i<_num_gui_elements; i++)
		{
			if(!_gui_elements_to_update[i].active || _gui_elements_to_update[i].update == -1)
				continue;
			_gui_elements_to_update[i].update();
		}
	}
	
	/// @function process_input
	static process_input = function()
	{
		var _num_gui_elements = array_length(gui_elements);
		
		if(mouse_check_button_released(mb_left))
		{
			if(clicked_element != -1 && clicked_element.on_click != -1)
			{
				clicked_element.on_click();	
			}
			clicked_element = -1;
		}
		
		var _previous_hover_element = hover_element;
		hover_element = -1;
		for(var i=_num_gui_elements-1; i>=0; i--)
		{
			if(!gui_elements[i].active || !gui_elements[i].hoverable)
				continue;
			if(point_in_rectangle(mouse_x,mouse_y,gui_elements[i].x,gui_elements[i].y,gui_elements[i].x+gui_elements[i].width,gui_elements[i].y+gui_elements[i].height))
			{
				hover_element = gui_elements[i];
				break;
			}
		}
		
		if(clicked_element != hover_element)
			clicked_element = -1;
			
		if(_previous_hover_element != hover_element)
		{
			if(_previous_hover_element !=- 1 && _previous_hover_element.on_unhover != -1)
				_previous_hover_element.on_unhover();
			if(hover_element != -1 && hover_element.on_hover != -1)
				hover_element.on_hover();
		}
			
		if(mouse_check_button_pressed(mb_left))
		{
			var _previous_selected_element = selected_element;
			if(hover_element == -1)
			{
				selected_element = -1;
			}
			else
			{
				if(hover_element.selectable)
				{
					selected_element = hover_element;
					clicked_element = hover_element;
					if(clicked_element.on_click_down != -1)
					{
						clicked_element.on_click_down();
					}
				}
			}
			if(_previous_selected_element != selected_element)
			{
				if(_previous_selected_element != -1 && _previous_selected_element.on_deselect != -1)
				{
					_previous_selected_element.on_deselect();	
				}
			}
		}
	}
	
	/// @function enter_gui_state
	/// @param gui_state
	static enter_gui_state = function(_gui_state)
	{
		gui_state = _gui_state;
		var _num_gui_elements = array_length(gui_elements);
		for(var i=0; i<_num_gui_elements; i++)
		{
			if(gui_elements[i].on_enter_gui_state != -1)
			{
				gui_elements[i].on_enter_gui_state(_gui_state);	
			}
		}
	}
}