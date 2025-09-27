extends Ability

var inheritance_level = 20

var particle_scene = preload("res://generic/particles/snow.tscn")
var particle_instance
var duration_timer = Timer.new()

func _ready() -> void:
	duration_timer.timeout.connect(clear)
	add_child(duration_timer)
	duration_timer.start(0.75 * level)
	particle_instance = particle_scene.instantiate()
	particle_instance.modulate = Config.get_team_color(ability_handler.get_enemy_group(), "secondary")
	add_child.call_deferred(particle_instance)
	ability_handler.speed_scale_modifiers.connect(speed_scale_modifiers)

func speed_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0.8

func add_level(value):
	clear()
	if value > 0:
		if value > level_offset:
			level_offset = value
		duration_timer.start(0.75 * level_offset)
	if not offsetting:
		offsetting = true
		call_deferred("offset")

func kill():
	if particle_instance.is_inside_tree():
		particle_instance.parent_died()
	super()
