extends Ability

var particle_scene = preload("res://paths/death/doom.tscn")
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
		particle_instance.modulate = Config.get_team_color(1, "secondary")
		particle_instance.position = sprite["offset"]
		particle_instance.process_material.emission_box_extents.x = sprite["size"].x * 0.5
		particle_instance.process_material.emission_box_extents.y = sprite["size"].y * 0.5
		particle_instance.amount = max(particle_instance.amount * sprite["size"].x * sprite["size"].y * 0.0005, 1)
		particle_instances.append(particle_instance)
		sprite["node"].add_child(particle_instance)

func damage_taken(damage) -> void:
	stored_damage += damage["final"]

func timeout():
	var damage = {"base" : stored_damage, "multiplier" : level*0.1}
	if swift_fate:
		damage["multiplier"] *= 1.5
	ability_handler.deal_damage(ability_handler.owner, damage, false, true, Config.get_team_color(1, "secondary"))
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
