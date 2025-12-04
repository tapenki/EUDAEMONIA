extends Ability

var pressurized_quills: bool
var pressure_multiplier = 1.0

func _ready() -> void:
	ability_handler.damage_taken.connect(damage_taken)

func _physics_process(delta: float) -> void:
	if pressurized_quills:
		pressure_multiplier = min(2.0, pressure_multiplier + 0.2 * delta * ability_handler.speed_scale)

func damage_taken(_source, _damage) -> void:
	var attack_scale = ability_handler.get_attack_scale({"source" : 0, "multiplier" : 1.5 * pressure_multiplier})
	var reach = 80 * attack_scale
	for entity in ability_handler.area_targets(global_position, reach):
		ability_handler.deal_damage(entity, {"source" : 0, "multiplier" : 2 * level * pressure_multiplier, "direction" : global_position.direction_to(entity.global_position)})
	pressure_multiplier = 1.0
	get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/Quills"), 16, global_position, attack_scale, Config.get_team_color(ability_handler.owner.group, "secondary"))

func inherit(handler, tier):
	if tier < 3:
		return
	super(handler, tier)
