extends Node2D

func _ready() -> void:
	$Label1.text = tr($Label1.text).format({
		"up": tr("[%s]" % InputMap.action_get_events("up")[0].as_text()),
		"left": tr("[%s]" % InputMap.action_get_events("left")[0].as_text()),
		"down": tr("[%s]" % InputMap.action_get_events("down")[0].as_text()),
		"right": tr("[%s]" % InputMap.action_get_events("right")[0].as_text()),
	})
	$Label2.text = tr($Label2.text).format({
		"attack": tr("[%s]" % InputMap.action_get_events("attack")[0].as_text())
	})
