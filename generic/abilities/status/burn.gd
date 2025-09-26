extends Ability

var inheritance_level = 20

var particle_scene = preload("res://generic/particles/burn.tscn")
var particle_instance
var burn_timer = ScaledTimer.new()

@export var damage_multiplier = 1.0
@export var total_ticks = 5
var ticks_left = 5

func _ready() -> void:
	burn_timer.ability_handler = ability_handler
	burn_timer.one_shot = false
	burn_timer.timeout.connect(tick)
	add_child(burn_timer)
	burn_timer.start()
	particle_instance = particle_scene.instantiate()
	particle_instance.modulate = Config.get_team_color(ability_handler.get_enemy_group(), "secondary")
	add_child.call_deferred(particle_instance)

func tick():
	if damage_multiplier > 0:
		ability_handler.owner.take_damage(ability_handler.owner, level * damage_multiplier, false)
	ticks_left -= 1
	if ticks_left == 0:
		clear()

func add_level(value):
	if value > 0:
		ticks_left = total_ticks
	super(value)

func kill():
	particle_instance.parent_died()
	super()
