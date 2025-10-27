extends Ability

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	var burn_instance = dying_entity.ability_handler.get_node_or_null("burn")
	if burn_instance:
		var target = ability_handler.find_target(position, 9999, {dying_entity : true})
		if target:
			ability_handler.apply_status(target.ability_handler, "burn", burn_instance.level)
			get_node("/root/Main").particle_beam(get_node("/root/Main/Particles/Firebeam"), dying_entity.global_position, target.global_position, 32, 1, Config.get_team_color(ability_handler.owner.group, "secondary"))

func inherit(_handler, _tier):
	return
