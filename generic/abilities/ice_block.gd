extends Ability

var inheritance_level = 3
var type = "Upgrade"

var texture = preload("res://generic/bubble.png")
var particle_scene = preload("res://generic/particles/impact.tscn")

var sprite_instance
var charges: int

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	ability_handler.damage_taken.connect(damage_taken)
	ability_handler.damage_taken_modifiers.connect(damage_taken_modifiers)
	sprite_instance = Sprite2D.new()
	sprite_instance.texture = texture
	sprite_instance.modulate = Config.get_team_color(ability_handler.owner.group, "secondary")
	sprite_instance.z_index = 1
	#sprite_instance.material = highlight
	add_child.call_deferred(sprite_instance)
	day_start(0)
	
func day_start(_day: int) -> void:
	charges = level
	sprite_instance.visible = true

func damage_taken(_damage) -> void:
	if charges > 0:
		get_node("/root/Main").spawn_particles(particle_scene, global_position, 2, Config.get_team_color(ability_handler.owner.group, "secondary"))
		charges -= 1
		if charges == 0:
			sprite_instance.visible = false

func damage_taken_modifiers(modifiers) -> void:
	if charges > 0:
		modifiers["multiplier"] = 0
