extends Node

## special effects
func play_sound(sound: String, pitch_scale = randf_range(0.9, 1.1)):
	var node = get_node("Audio/" + sound)
	node.pitch_scale = pitch_scale
	node.play()
