class_name EntitySprite extends Sprite2D

@onready var hurt_timer = ScaledTimer.new()

func _ready() -> void:
	if not material:
		material = load("res://shaders/colormap.tres").duplicate()
	var ability_relay = get_node("%AbilityRelay")
	ability_relay.damage_taken.connect(_on_damage_taken)
	hurt_timer.ability_relay = ability_relay
	add_child(hurt_timer)
	hurt_timer.timeout.connect(_on_hurt_timeout)

func _on_hurt_timeout() -> void:
	material.set_shader_parameter("colorfill", false)

func _on_damage_taken(_damage) -> void:
	material.set_shader_parameter("colorfill", true)
	hurt_timer.start(0.2)
