extends Button

@onready var rect = $"../"

func _ready() -> void:
	get_node("/root/Main").failed.connect(failed)

func _on_pressed() -> void:
	get_tree().reload_current_scene()

func failed() -> void:
	rect.visible = true
