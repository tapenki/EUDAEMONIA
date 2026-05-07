extends UIScaler

func _ready() -> void:
	super()
	self.text = "v[%s]" % ProjectSettings.get_setting("application/config/version")
