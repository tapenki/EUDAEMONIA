extends Ability

#var particle_scene = preload("res://generic/particles/boost.tscn")
#var particle_instance
var duration_timer = Timer.new()

func _ready() -> void:
	duration_timer.timeout.connect(clear)
	add_child(duration_timer)
	duration_timer.start(level)
	#particle_instance = particle_scene.instantiate()
	#particle_instance.modulate = Config.get_team_color(1, "secondary")
	#add_child.call_deferred(particle_instance)
	ability_handler.inh_speed_scale_modifiers.connect(inh_speed_scale_modifiers)

func inh_speed_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 1.5

func add_level(value):
	if value > 0:
		if value > duration_timer.time_left:
			level_offset = value - level
			duration_timer.start(value)
	else:
		clear()
	if not offsetting:
		offsetting = true
		call_deferred("offset")

func inherit(_handler, _tier):
	return
