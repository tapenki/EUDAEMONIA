extends Ability

var inheritance_level = 3

var firebeam_scene = preload("res://generic/particles/firebeam.tscn")

func _ready() -> void:
	ability_handler.self_death.connect(self_death)
	
func self_death():
	var attack_scale = ability_handler.get_attack_scale({"source" : 0, "multiplier" : 1})
	var reach = 100 * attack_scale
	for entity in ability_handler.area_targets(global_position, reach):
		ability_handler.apply_status(entity.ability_handler, "burn", level * 10)
		get_node("/root/Main").particle_beam(firebeam_scene, global_position, entity.global_position, 32, 1, Config.get_team_color(ability_handler.owner.group, "secondary"))
