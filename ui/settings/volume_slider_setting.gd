extends SliderSetting

@export var bus_index : String

func drag_ended(_changed: bool) -> void:
	super(_changed)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(bus_index), slider.value)
	get_node("/root/Main").play_sound("Click")
