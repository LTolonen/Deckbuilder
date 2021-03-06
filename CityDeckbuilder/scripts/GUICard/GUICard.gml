#macro GUI_LAYER_CARDS -100
#macro GUI_LAYER_HOVER_CARDS -500
#macro GUI_CARD_WIDTH 80
#macro GUI_CARD_HEIGHT 100
#macro GUI_CARD_EXPANDED_WIDTH 110
#macro GUI_CARD_EXPANDED_HEIGHT 130
#macro GUI_CARD_COLLAPSED_WIDTH 80
#macro GUI_CARD_COLLAPSED_HEIGHT 80
#macro GUI_CARD_HEADER_HEIGHT 13
#macro GUI_CARD_ART_BOX_HEIGHT 40
#macro GUI_CARD_TEXT_BORDER 3

/// @function GUICard
/// @param gui
/// @param x
/// @param y
/// @param card_data
/// @param card_entity_id
function GUICard(_gui, _x, _y, _card_data, _card_entity_id) : GUIElement(_gui,GUI_LAYER_CARDS,_x,_y,GUI_CARD_WIDTH,GUI_CARD_HEIGHT,"Card") constructor
{
	card_data = _card_data;
	card_entity_id = _card_entity_id;
	card_location = new CardLocation(ZONE.NONE,-1);
	
	gui.gui_entities[card_entity_id] = self;
	
	colour = card_frame_type_get_colour(card_data.frame_type);
	bg_colour = card_frame_type_get_background_colour(card_data.frame_type);
	
	text_box_height = height-GUI_CARD_HEADER_HEIGHT-GUI_CARD_ART_BOX_HEIGHT-2*GUI_CARD_TEXT_BORDER;
	text_width = width-4*GUI_CARD_TEXT_BORDER;
	text_height = text_box_height-2*GUI_CARD_TEXT_BORDER;
	text_fitting = new TokenisedTextFitting(card_data.text_tokenised,text_width,text_height,4,17);
	
	target_center_x = x+width div 2;
	target_center_y = y+height div 2;
	non_hover_depth = GUI_LAYER_CARDS;
	
	highlighted = false;
	
	buy_text_fitting = new TokenisedTextFitting(string_tokenise("Buy for "+string(card_data.buy_cost)+" {M}", FontVector7),100,20,4,17);
	
	static cleanup = function()
	{
		gui.gui_entities[card_entity_id] = -1;	
	}
	
	static update = function()
	{
		var _target_width = GUI_CARD_WIDTH;
		var _target_height = GUI_CARD_HEIGHT;
		if(is_hovered())
		{
			_target_width = GUI_CARD_EXPANDED_WIDTH;
			_target_height = GUI_CARD_EXPANDED_HEIGHT;
			set_depth(GUI_LAYER_HOVER_CARDS);
		}
		else
		{
			if(card_location.zone == ZONE.PLAY || card_location.zone == ZONE.SHOP)
			{
				_target_width = GUI_CARD_COLLAPSED_WIDTH;
				_target_height = GUI_CARD_COLLAPSED_HEIGHT;
			}
			set_depth(non_hover_depth);	
		}
		var _new_width = width + (_target_width-width) div 2;
		var _new_height = height + (_target_height-height) div 2;
		
		if(width != _new_width || height != _new_height)
			resize(_new_width, _new_height);
			
		var tx = target_center_x;
		var ty = target_center_y;
		if(is_hovered())
		{
			tx = clamp(tx,width/2,gui.canvas.width-width/2);
			ty = clamp(ty,height/2,gui.canvas.height-height/2);
		}
			
		var _dx = (tx - width div 2) - x;
		var _dy = (ty - height div 2) - y;
		if(abs(_dx) < 2)
		{
			x += _dx;
		}
		else
		{
			x += _dx div 2;	
		}
		if(abs(_dy) < 2)
		{
			y += _dy;
		}
		else
		{
			y += _dy div 2;	
		}
	}
	
	/// @function resize
	/// @param width
	/// @param height
	static resize = function(_width, _height)
	{
		x += (width-_width) div 2;
		y += (height-_height) div 2;
		width = _width;
		height = _height;
		text_box_height = height-GUI_CARD_HEADER_HEIGHT-GUI_CARD_ART_BOX_HEIGHT-2*GUI_CARD_TEXT_BORDER;
		text_width = width-4*GUI_CARD_TEXT_BORDER;
		text_height = text_box_height-2*GUI_CARD_TEXT_BORDER;
		text_fitting = new TokenisedTextFitting(card_data.text_tokenised,text_width,text_height,4,17);
	}
	
	static draw = function()
	{
		//Highlight
		if(highlighted)
		{
			draw_cornered_rectangle(x-2,y-2,x+width-1+2,y+height-1+2,COLOUR.WHITE,SprCornerRounded2Px);
		}
		
		//Frame
		draw_cornered_rectangle(x,y,x+width-1,y+height-1,colour,SprCornerRounded2Px);
		draw_set_color(COLOUR.BLUE_BLACK);
		draw_rectangle(x,y+GUI_CARD_HEADER_HEIGHT,x+width-1,y+GUI_CARD_HEADER_HEIGHT+GUI_CARD_ART_BOX_HEIGHT-1,false);
		if(text_box_height > 8)
			draw_cornered_rectangle(x+GUI_CARD_TEXT_BORDER,y+GUI_CARD_HEADER_HEIGHT+GUI_CARD_ART_BOX_HEIGHT+GUI_CARD_TEXT_BORDER,x+width-1-GUI_CARD_TEXT_BORDER,y+height-1-GUI_CARD_TEXT_BORDER,bg_colour,SprCornerRounded2Px);
		
		//Name
		draw_set_color(COLOUR.BLUE_BLACK);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_font(FontVector7);
		draw_text(x+width div 2 + 1,y+(GUI_CARD_HEADER_HEIGHT-7) div 2 + 1,card_data.name);
		draw_set_color(COLOUR.WHITE);
		draw_text(x+width div 2,y+(GUI_CARD_HEADER_HEIGHT-7) div 2,card_data.name);
		
		//Text Box
		draw_tokenised_text(x+width div 2,y+GUI_CARD_HEADER_HEIGHT+GUI_CARD_ART_BOX_HEIGHT+GUI_CARD_TEXT_BORDER+text_height div 2,text_fitting,fa_center,fa_middle);
		
		//Energy Cost
		if(card_data.worker_cost > 0)
		{
			var _icon_x = x+width-17-1;
			var _icon_y = y+GUI_CARD_HEADER_HEIGHT+1
			gpu_set_fog(true,resource_get_colour(RESOURCE.WORKERS),0,0);
			draw_sprite(SprResourceIcons,RESOURCE.WORKERS,_icon_x,_icon_y);
			gpu_set_fog(false,COLOUR.WHITE,0,0);
			
			draw_set_color(COLOUR.WHITE);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(FontVector7);
			draw_text(_icon_x+9,_icon_y+10,string(card_data.worker_cost));
		}
		
		//Buy Cost
		if(card_location.zone == ZONE.SHOP)
		{
			draw_cornered_rectangle(x+4,y+height+3,x+width-1-4,y+height+17,COLOUR.BLUE_BLACK,SprCornerRounded2Px);
			draw_set_color(COLOUR.WHITE);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_set_font(FontVector7);
			draw_tokenised_text(x+width/2,y+height+2,buy_text_fitting,fa_center,fa_top);
		}
	}
	
	static on_click = function()
	{
		if(gui.gui_state.gui_state_type == GUI_STATE_TYPE.GAME_MAIN)
		{
			if(card_location.zone == ZONE.HAND)
			{
				gui.game_gui_provide_input(new PlayCardInput(card_entity_id));
			}
			else if(card_location.zone == ZONE.SHOP)
			{
				gui.game_gui_provide_input(new BuyCardInput(card_entity_id));	
			}
		}
	}
	
	static on_enter_gui_state = function(_gui_state)
	{
		if(gui.gui_state.gui_state_type == GUI_STATE_TYPE.GAME_MAIN)
		{
			highlighted = false;
			if(card_location.zone == ZONE.HAND)
			{
				if(_gui_state.input_request.playable_cards.find_item_index(card_entity_id) != -1)
					highlighted = true;
			}
			else if(card_location.zone == ZONE.SHOP)
			{
				if(_gui_state.input_request.buyable_cards.find_item_index(card_entity_id) != -1)
					highlighted = true;
			}
		}
	}
}