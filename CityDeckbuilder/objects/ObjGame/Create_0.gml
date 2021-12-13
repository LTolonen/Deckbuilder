randomize();
global.DEBUG = false;

card_set = card_set_init();
controller = new GameController(card_set);

game_gui = new GameGUI();
active_gui = game_gui;
game_gui.input_provider.input_provider_register(controller);
controller.game_state.game_event_subject_add_observer(game_gui);

controller.controller_init();