function GameState(_card_set, _predicament_set) : GameEventSubject() constructor
{
	card_set = _card_set;
	predicament_set = _predicament_set;
	entity_set = new EntitySet();
	draw_pile = new List();
	discard_pile = new List();
	hand = new List();
	played_cards = new List();
	shop = new Shop(SHOP_NUM_SLOTS);
	predicament = -1;
	resources = array_create(RESOURCE.COUNT,0);
	turn_number = 0;
	energy_max = 1;
	
	
	/// @function game_init
	static game_init = function()
	{
		//Set Health
		game_set_resource(RESOURCE.HEALTH,3);
		
		//Populate Starter Deck
		var _copper_data = card_set.card_set_find_card_by_name("Copper");
		var _silver_data = card_set.card_set_find_card_by_name("Silver");
		var _gold_data = card_set.card_set_find_card_by_name("Gold");
		var _tree_data = card_set.card_set_find_card_by_name("Tree");
		var _infantry_data = card_set.card_set_find_card_by_name("Infantry");
		var _study_data = card_set.card_set_find_card_by_name("Study");
		var _generator_data = card_set.card_set_find_card_by_name("Generator");
		repeat(4)
		{
			discard_pile.add_item(new Card(entity_set, _copper_data, new CardLocation(ZONE.DISCARD_PILE,-1)));
			discard_pile.add_item(new Card(entity_set, _silver_data, new CardLocation(ZONE.DISCARD_PILE,-1)));
			discard_pile.add_item(new Card(entity_set, _gold_data, new CardLocation(ZONE.DISCARD_PILE,-1)));
			discard_pile.add_item(new Card(entity_set, _tree_data, new CardLocation(ZONE.DISCARD_PILE,-1)));
			discard_pile.add_item(new Card(entity_set, _infantry_data, new CardLocation(ZONE.DISCARD_PILE,-1)));
			discard_pile.add_item(new Card(entity_set, _study_data, new CardLocation(ZONE.DISCARD_PILE,-1)));
			discard_pile.add_item(new Card(entity_set, _generator_data, new CardLocation(ZONE.DISCARD_PILE,-1)));
			game_change_resource(RESOURCE.POWER,1);
		}
		
		//Populate Shop
		shop.shop_populate(self);
		
		//Choose Predicament
		game_add_predicament();
		
		game_turn_begin();
	}
	
	/// @function game_draw_card
	static game_draw_card = function()
	{
		if(draw_pile.num_items == 0 && discard_pile.num_items > 0)
		{
			for(var i=0; i<discard_pile.num_items; i++)
			{
				var _card = discard_pile.items[i];
				draw_pile.add_item(_card);	
				_card.card_location = new CardLocation(ZONE.DRAW_PILE,-1);
			}
			discard_pile.empty_list();
			draw_pile.shuffle_list();
			game_event_subject_notify(new ShuffleGameEvent());
		}
		if(draw_pile.num_items > 0)
		{
			var _card = draw_pile.pop_last_item();
			hand.add_item(_card);
			_card.card_location = new CardLocation(ZONE.HAND,-1);
			game_event_subject_notify(new CardDrawnGameEvent(_card.entity_id,_card.card_data));
		}
	}
	
	/// @function game_discard_hand
	static game_discard_hand = function()
	{
		for(var i=0; i<hand.num_items; i++)
		{
			var _card = hand.items[i];
			discard_pile.add_item(_card);
			_card.card_location = new CardLocation(ZONE.DISCARD_PILE,-1);
			game_event_subject_notify(new CardDiscardedFromHandGameEvent(_card.entity_id,_card.card_data));
		}
		hand.empty_list();
	}
	
	/// @function game_discard_card
	/// @param card_entity_id
	static game_discard_card = function(_card_entity_id)
	{
		for(var i=0; i<hand.num_items; i++)
		{
			var _card = hand.items[i];
			if(_card.entity_id == _card_entity_id)
			{
				discard_pile.add_item(_card);
				_card.card_location = new CardLocation(ZONE.DISCARD_PILE,-1);
				hand.remove_item_at_index(i);
				game_event_subject_notify(new CardDiscardedFromHandGameEvent(_card.entity_id,_card.card_data));
				break;
			}
		}
	}
	
	/// @function game_refill_energy
	static game_refill_energy = function()
	{
		game_set_resource(RESOURCE.ENERGY,energy_max);	
	}
	
	/// @function game_change_resource
	/// @param resource
	/// @param delta_amount
	static game_change_resource = function(_resource, _delta_amount)
	{
		resources[_resource] += _delta_amount;
		game_event_subject_notify(new ResourceChangeGameEvent(_resource, resources[_resource], _delta_amount));
	}
	
	/// @function game_set_resource
	/// @param resource
	/// @param amount
	static game_set_resource = function(_resource, _amount)
	{
		var _delta_amount = _amount - resources[_resource];
		resources[_resource] = _amount;
		game_event_subject_notify(new ResourceChangeGameEvent(_resource, resources[_resource], _delta_amount));
	}
	
	/// @function game_turn_begin
	static game_turn_begin = function()
	{
		turn_number++;
		game_event_subject_notify(new TurnBeginGameEvent(turn_number));
		game_refill_energy();
		repeat(5)
		{
			game_draw_card();	
		}
	}
	
	/// @function game_turn_end
	static game_turn_end = function()
	{
		game_discard_hand();
		game_tick_down_predicament();
	}
	
	/// @function game_play_card
	/// @param card_entity_id
	static game_play_card = function(_card_entity_id)
	{
		var _card = entity_set.entity_set_get_entity(_card_entity_id);
		if(_card.card_data.energy_cost != 0)
		{
			game_change_resource(RESOURCE.ENERGY,-_card.card_data.energy_cost);
		}
		for(var i=0; i<_card.card_data.num_on_play_effects; i++)
		{
			_card.card_data.on_play_effects[i].effect_perform(self);	
		}
		game_discard_card(_card_entity_id);
		game_event_subject_notify(new CardPlayedGameEvent(_card_entity_id,_card.card_data));
	}
	
	/// @function game_buy_card
	/// @param card_entity_id
	static game_buy_card = function(_card_entity_id)
	{
		var _card = entity_set.entity_set_get_entity(_card_entity_id);
		if(_card.card_data.buy_cost != 0)
		{
			game_change_resource(RESOURCE.MONEY,-_card.card_data.buy_cost);
		}
		if(_card.card_data.strength != 0)
		{
			game_change_resource(RESOURCE.POWER,_card.card_data.strength);
		}
		for(var i=0; i<shop.num_slots; i++)
		{
			if(shop.cards[i] == -1)
				continue;
			if(shop.cards[i].entity_id != _card_entity_id)
				continue;
			shop.cards[i] = -1;
		}
		hand.add_item(_card);
		_card.card_location = new CardLocation(ZONE.HAND,-1);
		game_event_subject_notify(new CardBoughtGameEvent(_card_entity_id,_card.card_data));
		
		shop.shop_populate(self);
	}
	
	/// @function game_reroll_shop
	static game_reroll_shop = function()
	{
		if(shop.reroll_cost != 0)
		{
			game_change_resource(RESOURCE.MONEY,-shop.reroll_cost);
		}
		shop.shop_reroll(self);
	}
	
	/// @function game_add_predicament
	static game_add_predicament = function()
	{
		predicament = new Predicament(predicament_set.predicament_set_choose_predicament());
		game_event_subject_notify(new PredicamentAddedGameEvent(predicament.predicament_data));
	}
	
	/// @function game_tick_down_predicament
	static game_tick_down_predicament = function()
	{
		if(predicament == -1)
			return;
		predicament.turns_remaining--;
		game_event_subject_notify(new PredicamentTickDownGameEvent(predicament.predicament_data,predicament.turns_remaining));
		
		if(predicament.turns_remaining > 0)
			return;
		
		var _cleared = true;
		for(var i=0; i<RESOURCE.COUNT; i++)
		{
			var _requirement = predicament.predicament_data.resource_requirements[i];
			if(_requirement <= 0)
				continue;
			if(resources[i] <= _requirement)
			{
				_cleared = false;
				if(i != RESOURCE.POWER)
					game_set_resource(i,0);
			}
			else
			{
				if(i != RESOURCE.POWER)
					game_change_resource(i,-_requirement);
			}
		}
		if(!_cleared)
			game_change_resource(RESOURCE.HEALTH,-1);
			
		game_event_subject_notify(new PredicamentRemovedGameEvent(predicament.predicament_data));
		game_add_predicament();
	}
}