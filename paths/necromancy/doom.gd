extends Ability

var particle_scene = preload("res://paths/necromancy/doom.tscn")
var particle_instances: Array
var doom_timer = ScaledTimer.new()

var stored_damage: float
var swift_fate: bool

func _ready() -> void:
	ability_handler.damage_taken.connect(damage_taken)
	doom_timer.ability_handler = ability_handler
	doom_timer.timeout.connect(timeout)
	add_child(doom_timer)
	doom_timer.start(5)
	for sprite in ability_handler.owner.get_sprites():
		var particle_instance = particle_scene.instantiate()
		particle_instance.modulate = Config.get_team_color(1, "tertiary")
		particle_instance.position = sprite["offset"]
		particle_instance.process_material.emission_box_extents.x = sprite["size"].x * 0.5
		particle_instance.process_material.emission_box_extents.y = sprite["size"].y * 0.5
		particle_instance.amount = max(particle_instance.amount * sprite["size"].x * sprite["size"].y * 0.0005, 1)
		particle_instances.append(particle_instance)
		sprite["node"].add_child.call_deferred(particle_instance)

func damage_taken(_source, damage) -> void:
	stored_damage += damage["final"]

func timeout():
	var damage = {"source" : stored_damage, "multiplier" : level, "piercing" : true}
	if swift_fate:
		damage["multiplier"] *= 1.5
	damage["final"] = damage["source"] * damage["multiplier"]
	ability_handler.owner.take_damage(ability_handler, damage, false)
	get_node("/root/Main").floating_text(global_position + Vector2(randi_range(-16, 16), -16 + randi_range(-16, 16)), str(int(damage["final"])), Config.get_team_color(1, "tertiary"))
	clear()

func add_level(value):
	if value > 0:
		doom_timer.start()
	super(value)

func kill():
	for i in particle_instances:
		if i.is_inside_tree():
			i.self_death()
	super()

func inherit(_handler, _tier):
	return
