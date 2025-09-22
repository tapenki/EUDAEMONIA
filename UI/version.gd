extends Label

func _ready() -> void:
	text = "v%sa" % ProjectSettings.get_setting("application/config/version")
