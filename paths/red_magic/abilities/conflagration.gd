extends Ability

var inheritance_level = 3

var firebeam_scene = preload("res://generic/particles/firebeam.tscn")

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	var burn_instance = dying_entity.ability_handler.get_node_or_null("burn")
	if burn_instance:
		var target = ability_handler.find_target(position, 9999, {dying_entity : true})
		if target:
			var spread_burn = ability_handler.apply_status(target.ability_handler, "burn", burn_instance.level)
			spread_burn.damage_multiplier += burn_instance.damage_multiplier - 1
			get_node("/root/Main").particle_beam(firebeam_scene, dying_entity.global_position, target.global_position, 32, 1, Config.get_team_color(ability_handler.owner.group, "secondary"))
