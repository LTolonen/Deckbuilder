#macro GUI_LAYER_CARD_SELECTOR -500
#macro GUI_CARD_SELECTOR_HEIGHT 160
#macro GUI_CARD_SELECTOR_BORDER_WIDTH 3
#macro GUI_CARD_SELECTOR_CARD_BORDER_WIDTH 2
#macro GUI_CARD_SELECTOR_PADDING 3
#macro GUI_CARD_SELECTOR_SEPARATION 8
#macro GUI_CARD_SELECTOR_HEADER_HEIGHT 12
/// @function GUICardSelector
/// @param gui
/// @param x
/// @param y
/// @param min_num_cards
/// @param max_num_cards
/// @param text
function GUICardSelector(_gui, _x, _y, _min_num_cards, _max_num_cards,  _text) : GUIElement(_gui, GUI_LAYER_CARD_SELECTOR,_x, _y, 0, GUI_CARD_SELECTOR_HEIGHT, "CardSelector") constructor
{
	min_num_cards = _min_num_cards;
	max_num_cards = _max_num_cards;
	width = max_num_cards * GUI_CARD_WIDTH + (max_num_cards-1) * GUI_CARD_SELECTOR_SEPARATION + 2 * GUI_CARD_SELECTOR_PADDING + 2 * GUI_CARD_SELECTOR_BORDER_WIDTH;
	text = _text;
	colour = COLOUR.BROWN;
	bg_colour = COLOUR.DARKEST_BROWN;
	
	submit_button = new GUISelectorSubmitButton(gui,self);
	
	static draw = function()
	{
		draw_cornered_rectangle(x,y,x+width-1,y+height-1,colour,SprCornerRounded2Px);
		draw_cornered_rectangle(x+GUI_CARD_SELECTOR_BORDER_WIDTH,y+GUI_CARD_SELECTOR_BORDER_WIDTH,x+width-1-GUI_CARD_SELECTOR_BORDER_WIDTH,y+height-1-GUI_CARD_SELECTOR_BORDER_WIDTH,bg_colour,SprCornerRounded2Px);
		draw_set_font(FontVector7);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
		draw_text(x+width div 2, y+GUI_CARD_SELECTOR_BORDER_WIDTH+GUI_CARD_SELECTOR_PADDING,text);
		
		for(var i=0; i<max_num_cards; i++)
		{
			var x1 = x + GUI_CARD_SELECTOR_BORDER_WIDTH + GUI_CARD_SELECTOR_PADDING + i * (GUI_CARD_WIDTH + GUI_CARD_SELECTOR_SEPARATION);
			var y1 = y + GUI_CARD_SELECTOR_BORDER_WIDTH + GUI_CARD_SELECTOR_PADDING + GUI_CARD_SELECTOR_HEADER_HEIGHT;
			draw_cornered_rectangle(x1,y1,x1+GUI_CARD_WIDTH-1,y1+GUI_CARD_HEIGHT-1,COLOUR.WHITE,SprCornerRounded2Px);
			draw_cornered_rectangle(x1+GUI_CARD_SELECTOR_CARD_BORDER_WIDTH,y1+GUI_CARD_SELECTOR_CARD_BORDER_WIDTH,x1+GUI_CARD_WIDTH-1-GUI_CARD_SELECTOR_CARD_BORDER_WIDTH,y1+GUI_CARD_HEIGHT-1-GUI_CARD_SELECTOR_CARD_BORDER_WIDTH,bg_colour,SprCornerRounded2Px);
		}
	}
}