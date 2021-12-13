/// @function PlayCardInput
/// @param card_entity_id
function PlayCardInput(_card_entity_id) : Input(INPUT_TYPE.PLAY_CARD) constructor
{
	card_entity_id = _card_entity_id;
}