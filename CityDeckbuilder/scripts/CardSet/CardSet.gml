function CardSet() constructor
{
	num_cards = 0;
	cards = array_create(0);
	card_pool_money = new Pool();
	card_pool_resources = new Pool();
	card_pool_general = new Pool();
	
	/// @function card_set_add_card
	/// @param card_data
	static card_set_add_card = function(_card_data)
	{
		cards[num_cards++] = _card_data;	
	}
	
	/// @function card_set_find_card_by_name
	/// @param card_name
	static card_set_find_card_by_name = function(_card_name)
	{
		for(var i=0; i<num_cards; i++)
		{
			if(cards[i].name == _card_name	)
				return cards[i];
		}
		return -1;
	}
}

function card_set_init()
{
	card_set = new CardSet();
	
	var _card_data;

	_card_data = new CardData("Coin",1,0,0,"Gain 1 {M} .",CARD_FRAME_TYPE.MONEY);
	_card_data.card_data_add_effect(new ResourceGainEffect(RESOURCE.MONEY,1));
	card_set.card_set_add_card(_card_data);
	card_set.card_pool_money.pool_add_item(_card_data,3);
	
	_card_data = new CardData("Ingot",4,0,0,"Gain 2 {M} .",CARD_FRAME_TYPE.MONEY);
	_card_data.card_data_add_effect(new ResourceGainEffect(RESOURCE.MONEY,2));
	card_set.card_set_add_card(_card_data);
	card_set.card_pool_money.pool_add_item(_card_data,5);
	
	_card_data = new CardData("Jewel",6,0,0,"Gain 3 {M} .",CARD_FRAME_TYPE.MONEY);
	_card_data.card_data_add_effect(new ResourceGainEffect(RESOURCE.MONEY,3));
	card_set.card_set_add_card(_card_data);
	card_set.card_pool_money.pool_add_item(_card_data,3);
	card_set.card_pool_general.pool_add_item(_card_data,3);
	
	_card_data = new CardData("Crop",2,0,0,"Gain 1 {F} .",CARD_FRAME_TYPE.FOOD);
	_card_data.card_data_add_effect(new ResourceGainEffect(RESOURCE.FOOD,1));
	card_set.card_set_add_card(_card_data);
	card_set.card_pool_resources.pool_add_item(_card_data,3);
	
	_card_data = new CardData("Soldier",1,0,1,"Unplayable \n Grants 1 {P} .",CARD_FRAME_TYPE.POWER);
	_card_data.is_playable = false;
	card_set.card_set_add_card(_card_data);
	card_set.card_pool_resources.pool_add_item(_card_data,3);
	
	_card_data = new CardData("Study",3,1,0,"Draw 2 cards.",CARD_FRAME_TYPE.ACTION);
	_card_data.card_data_add_effect(new CardDrawEffect(2));
	card_set.card_set_add_card(_card_data);
	card_set.card_pool_general.pool_add_item(_card_data,3);
	
	_card_data = new CardData("Generator",2,0,0,"Gain 1 {E} .",CARD_FRAME_TYPE.ENERGY);
	_card_data.card_data_add_effect(new ResourceGainEffect(RESOURCE.ENERGY,1));
	card_set.card_set_add_card(_card_data);
	card_set.card_pool_general.pool_add_item(_card_data,3);
	
	_card_data = new CardData("Village",3,1,0,"Gain 2 {E} . \n Draw a card.",CARD_FRAME_TYPE.ENERGY);
	_card_data.card_data_add_effect(new ResourceGainEffect(RESOURCE.ENERGY,2));
	_card_data.card_data_add_effect(new CardDrawEffect(1));
	card_set.card_set_add_card(_card_data);
	card_set.card_pool_general.pool_add_item(_card_data,3);
	
	return card_set;
}