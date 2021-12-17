/// @function GUIRerollButton
/// @param gui
/// @param x
/// @param y
function GUIRerollButton(_gui,_x, _y) : GUIButton(_gui,GUI_LAYER_BUTTONS,_x,_y,120,30,"Reroll") constructor
{
	reroll_cost = 0;
	text_fitting = -1;
	gui_reroll_button_update_text_fitting();

	static on_click = function()
	{
		if(gui.gui_state.gui_state_type == GUI_STATE_TYPE.GAME_MAIN)
		{
			gui.game_gui_provide_input(new RerollShopInput());
		}
	}
	
	static draw = function()
	{
		draw_cornered_rectangle(x,y,x+width-1,y+height-1,COLOUR.LAVENDAR,SprCornerRounded2Px);
		var _colour = COLOUR.DARKEST_BLUE;
		if(is_hovered())
			_colour = COLOUR.DARK_LAVENDAR;
		draw_cornered_rectangle(x+3,y+3,x+width-1-3,y+height-1-3,_colour,SprCornerRounded2Px);
		
		draw_tokenised_text(x+width div 2,y+height div 2,text_fitting,fa_center,fa_middle);
	}
	
	/// @function gui_reroll_button_update_text_fitting
	static gui_reroll_button_update_text_fitting = function()
	{
		var _text = "Reroll for "+string(reroll_cost)+" {M}";
		var _tokens = string_tokenise(_text,FontVector7);
		text_fitting = new TokenisedTextFitting(_tokens,width-8,17,4,17);
	}
}