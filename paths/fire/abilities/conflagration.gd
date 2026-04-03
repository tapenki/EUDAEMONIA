extends Ability

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	var burn_instance = dying_entity.ability_relay.get_node_or_null("burn")
	if burn_instance:
		var target = ability_relay.find_target(position, 9999, {dying_entity : true})
		if target:
			ability_relay.apply_status(target.ability_relay, "burn", burn_instance.level)
			get_node("/root/Main").particle_beam(get_node("/root/Main/Particles/Firebeam"), dying_entity.global_position, target.global_position, 32, 1, Config.get_team_color(ability_relay.owner.group, "secondary"))

func inherit(_handler, _tier):
	return
