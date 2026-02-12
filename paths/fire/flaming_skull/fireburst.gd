extends Ability

var inheritance_level = 3

func _ready() -> void:
	ability_handler.death_effects.connect(death_effects)
	
func death_effects():
	var attack_scale = ability_handler.get_attack_scale({"base" : 0, "multiplier" : 1})
	var reach = 150 * attack_scale
	for entity in ability_handler.area_targets(global_position, reach):
		ability_handler.apply_status(entity.ability_handler, "burn", level * 10)
		get_node("/root/Main").particle_beam(get_node("/root/Main/Particles/Firebeam"), global_position, entity.global_position, 32, 1, Config.get_team_color(ability_handler.owner.group, "secondary"))
