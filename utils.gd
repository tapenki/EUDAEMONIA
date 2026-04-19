extends Node

signal controls_changed(action: String)

func set_keybind(action, keycode):
	InputMap.action_erase_event(action, InputMap.action_get_events(action)[0])
	var new_event = InputEventKey.new()
	new_event.keycode = keycode
	InputMap.action_add_event(action, new_event)
	Config.config.set_value("keyboard_controls", action, [0, keycode])
	Config.config.save("user://config.ini")
	controls_changed.emit(action)

func set_mousebind(action, button_index):
	InputMap.action_erase_event(action, InputMap.action_get_events(action)[0])
	var new_event = InputEventMouseButton.new()
	new_event.button_index = button_index
	InputMap.action_add_event(action, new_event)
	Config.config.set_value("keyboard_controls", action, [1, button_index])
	Config.config.save("user://config.ini")
	controls_changed.emit(action)
