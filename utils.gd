extends Node

signal controls_changed(action: String)

func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event) -> void:
	##is_action_just_pressed_by_event doesn't work with mouse buttons :(
	if Input.is_action_just_pressed("toggle_fullscreen") and event.is_action("toggle_fullscreen"): 
		var window = get_window()
		if window.mode == window.MODE_FULLSCREEN:
			window.mode = window.MODE_WINDOWED
		else:
			window.mode = window.MODE_FULLSCREEN

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
