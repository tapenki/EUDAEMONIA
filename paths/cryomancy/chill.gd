extends Ability

var particle_scene = preload("res://paths/cryomancy/snow.tscn")
var particle_instance
var duration_timer = Timer.new()

func _ready() -> void:
	duration_timer.timeout.connect(clear)
	add_child(duration_timer)
	duration_timer.start(0.75 * level)
	particle_instance = particle_scene.instantiate()
	particle_instance.modulate = Config.get_team_color(1, "secondary")
	add_child.call_deferred(particle_instance)
	ability_handler.inh_speed_scale_modifiers.connect(inh_speed_scale_modifiers)

func inh_speed_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0.8

func add_level(value):
	if value > 0:
		if 0.75 * value > duration_timer.time_left:
			clear()
			level_offset = value
			duration_timer.start(0.75 * value)
	else:
		clear()
	if not offsetting:
		offsetting = true
		call_deferred("offset")

func kill():
	if particle_instance.is_inside_tree():
		particle_instance.parent_died()
	super()

func inherit(_handler, _tier):
	return
