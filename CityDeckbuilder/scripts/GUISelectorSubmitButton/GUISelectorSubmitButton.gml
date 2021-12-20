/// @function GUISelectorSubmitButton
/// @param gui
/// @param gui_card_selector
function GUISelectorSubmitButton(_gui, _gui_card_selector) : GUIButton(_gui,GUI_LAYER_CARD_SELECTOR,0,0,80,30,"Submit") constructor
{
	gui_card_selector = _gui_card_selector;
	x = gui_card_selector.x + gui_card_selector.width div 2 - width div 2;
	y = gui_card_selector.y + gui_card_selector.height - GUI_CARD_SELECTOR_BORDER_WIDTH - GUI_CARD_SELECTOR_PADDING - height;
}