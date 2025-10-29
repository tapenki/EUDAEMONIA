extends Ability

var particle_scene = preload("res://paths/electromancy/shock.tscn")
var particle_instance
var duration_timer = ScaledTimer.new()

func _ready() -> void:
	duration_timer.ability_handler = ability_handler
	duration_timer.timeout.connect(clear)
	add_child(duration_timer)
	duration_timer.start(2.5 * level)
	particle_instance = particle_scene.instantiate()
	particle_instance.modulate = Config.get_team_color(1, "secondary")
	add_child.call_deferred(particle_instance)

func add_level(value):
	if value > 0:
		if 2.5 * value > duration_timer.time_left:
			level_offset = value - level
			duration_timer.start(2.5 * value)
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
