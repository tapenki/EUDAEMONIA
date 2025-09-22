extends Ability

var inheritance_level = 3
var type = "Upgrade"

var burn_script = preload("res://generic/abilities/status/burn.gd")
var firebeam_scene = preload("res://generic/particles/firebeam.tscn")

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	var burn_instance = dying_entity.ability_handler.get_node_or_null("burn")
	if burn_instance:
		var target = ability_handler.find_target(position, 9999, {dying_entity : true})
		if target:
			ability_handler.apply_status(target.ability_handler, burn_script, "burn", burn_instance.level * 0.5 * level)
			get_node("/root/Main").particle_beam(firebeam_scene, dying_entity.global_position, target.global_position, 32, 1, get_node("/root/Main/Config").get_team_color(ability_handler.owner.group, "secondary"))
