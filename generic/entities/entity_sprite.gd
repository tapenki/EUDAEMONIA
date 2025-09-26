extends Sprite2D

@onready var hurt_timer = $Hurt

@export var base_texture: Texture2D
@export var hurt_texture: Texture2D

func _on_hurt_timeout() -> void:
	texture = base_texture

func _on_damage_taken(_source, _damage) -> void:
	texture = hurt_texture
	hurt_timer.start()
