extends NinePatchRect

@onready var tip_sprite = get_node("TipSprite")

@export var ability_relay: Node
var alive = true

func _ready() -> void:
	ability_relay.self_death.connect(parent_died)

func _physics_process(_delta: float) -> void:
	tip_sprite.scale = Vector2(1.1, 1.1) * (1 - sin(Time.get_ticks_msec()*0.02) * 0.1)
	if not alive:
		global_position += Vector2(0, size.y * scale.y * 0.1).rotated(rotation)
		scale.y *= 0.8
		if scale.y <= 0.1:
			queue_free()

func parent_died():
	var old_scale = get_parent().scale
	var old_rotation = get_parent().rotation
	reparent(get_node("/root/Main/Effects"))
	scale = old_scale
	rotation = old_rotation
	alive = false
