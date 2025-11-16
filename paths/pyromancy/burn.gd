extends Ability

var particle_scene = preload("res://paths/pyromancy/burn.tscn")
var particle_instances: Array
var burn_timer = ScaledTimer.new()

@export var total_ticks = 5
var ticks_left = 5

func _ready() -> void:
	burn_timer.ability_handler = ability_handler
	burn_timer.one_shot = false
	burn_timer.timeout.connect(tick)
	add_child(burn_timer)
	burn_timer.start()
	for i in ability_handler.owner.prestidigitate():
		var particle_instance = particle_scene.instantiate()
		particle_instance.modulate = Config.get_team_color(1, "secondary")
		particle_instance.position = i.position
		particle_instance.process_material.emission_box_extents.x = i.size.x * 0.5
		particle_instance.process_material.emission_box_extents.y = i.size.y * 0.5
		particle_instance.amount = max(particle_instance.amount * i.size.x * i.size.y * 0.0005, 1)
		particle_instances.append(particle_instance)
		add_child.call_deferred(particle_instance)

func tick():
	var damage = {"source" : level, "multiplier" : 1.0}
	ability_handler.damage_taken_modifiers.emit(damage)
	damage["final"] = damage["source"] * damage["multiplier"]
	ability_handler.owner.take_damage(ability_handler, damage, false)
	get_node("/root/Main").floating_text(global_position + Vector2(randi_range(-16, 16), -16 + randi_range(-16, 16)), str(int(damage["final"])), Config.get_team_color(1, "secondary"))
	ticks_left -= 1
	if ticks_left == 0:
		clear()

func add_level(value):
	if value > 0:
		ticks_left = total_ticks
	super(value)

func kill():
	for i in particle_instances:
		if i.is_inside_tree():
			i.self_death()
	super()

func inherit(_handler, _tier):
	return
