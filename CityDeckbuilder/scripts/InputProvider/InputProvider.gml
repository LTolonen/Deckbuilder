/// @function InputProvider
function InputProvider() constructor
{
	controller = -1;
	current_input_request = -1;
	
	/// @function input_provider_register
	/// @param controller
	static input_provider_register = function(_controller)
	{
		if(controller != -1)
		{
			controller.input_provider = -1;	
		}
		controller = _controller;
		controller.input_provider = self;
	}
	
	/// @function input_provider_provide_input
	/// @param input
	static input_provider_provide_input = function(_input)
	{
		if(current_input_request == -1)
		{
			throw "Attempted to provide input with no current request";	
		}
		
		var _result = controller.controller_process_input(_input);
		return _result;
	}
}