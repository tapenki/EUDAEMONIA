extends Ability

var particle_scene = preload("res://paths/fire/burn.tscn")
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
	for sprite in ability_handler.owner.get_sprites():
		var particle_instance = particle_scene.instantiate()
		particle_instance.modulate = Config.get_team_color(1, "secondary")
		particle_instance.position = sprite["offset"]
		particle_instance.emission_rect_extents.x = sprite["size"].x * 0.5
		particle_instance.emission_rect_extents.y = sprite["size"].y * 0.5
		particle_instance.amount = max(particle_instance.amount * sprite["size"].x * sprite["size"].y * 0.0005, 1)
		particle_instances.append(particle_instance)
		sprite["node"].add_child(particle_instance)

func tick():
	ability_handler.deal_damage(ability_handler.owner, {"base" : level, "multiplier" : 1.0, "skip_output_modifiers": true, "skip_immunity": true}, Config.get_team_color(1, "secondary"))
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
