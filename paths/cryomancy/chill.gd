extends Ability

var particle_scene = preload("res://paths/cryomancy/snow.tscn")
var particle_instances: Array
var duration_timer = Timer.new()

func _ready() -> void:
	duration_timer.timeout.connect(clear)
	add_child(duration_timer)
	duration_timer.start(0.75 * level)
	for sprite in ability_handler.owner.get_sprites():
		var particle_instance = particle_scene.instantiate()
		particle_instance.modulate = Config.get_team_color(1, "secondary")
		particle_instance.position = sprite["offset"]
		particle_instance.process_material.emission_box_extents.x = sprite["size"].x * 0.5
		particle_instance.process_material.emission_box_extents.y = sprite["size"].y * 0.5
		particle_instance.amount = max(particle_instance.amount * sprite["size"].x * sprite["size"].y * 0.0005, 1)
		particle_instances.append(particle_instance)
		sprite["node"].add_child.call_deferred(particle_instance)
	ability_handler.inh_speed_scale_modifiers.connect(inh_speed_scale_modifiers)

func inh_speed_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0.8

func add_level(value):
	if value > 0:
		if 0.75 * value > duration_timer.time_left:
			level_offset = value - level
			duration_timer.start(0.75 * value)
	else:
		clear()
	if not offsetting:
		offsetting = true
		call_deferred("offset")

func kill():
	for i in particle_instances:
		if i.is_inside_tree():
			i.self_death()
	super()

func inherit(_handler, _tier):
	return
