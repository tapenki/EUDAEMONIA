extends Ability

var inheritance_level = 3

func _ready() -> void:
	ability_relay.death_effects.connect(death_effects)
	
func death_effects():
	var attack_scale = ability_relay.get_attack_scale({"base" : 0, "multiplier" : 1})
	var reach = 150 * attack_scale
	for entity in ability_relay.area_targets(global_position, reach):
		ability_relay.apply_status(entity.ability_relay, "burn", level * 10)
		get_node("/root/Main").particle_beam(get_node("/root/Main/Particles/Firebeam"), global_position, entity.global_position, 32, 1, Config.get_team_color(ability_relay.owner.group, "secondary"))
