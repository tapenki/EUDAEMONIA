extends Ability

var inheritance_level = 20

var particle_scene = preload("res://paths/red_magic/burn.tscn")
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
	particle_instance.modulate = Config.get_team_color(1, "secondary")
	add_child.call_deferred(particle_instance)

func tick():
	var damage = {"source" : level, "multiplier" : damage_multiplier}
	ability_handler.damage_taken_modifiers.emit(damage)
	var damage_final = damage["source"] * damage["multiplier"]
	ability_handler.owner.take_damage(ability_handler, damage_final, false)
	if Config.config.get_value("gameplay", "damage_numbers"): ## damage numbers
		get_node("/root/Main/FloatingText").floating_text(global_position + Vector2(randi_range(-16, 16), -16 + randi_range(-16, 16)), str(int(damage_final)), Config.get_team_color(1, "secondary"))
	ticks_left -= 1
	if ticks_left == 0:
		clear()

func add_level(value):
	if value > 0:
		ticks_left = total_ticks
	super(value)

func kill():
	if particle_instance.is_inside_tree():
		particle_instance.parent_died()
	super()
