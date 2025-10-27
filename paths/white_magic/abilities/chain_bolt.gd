extends Ability

var chain = {}

func _ready() -> void:
	ability_handler.crit_chance_modifiers.connect(crit_chance_modifiers)
	ability_handler.damage_dealt.connect(damage_dealt)

func crit_chance_modifiers(_entity, modifiers) -> void:
	modifiers["source"] += 10 * level

func damage_dealt(entity, _damage, crits_dealt) -> void:
	if chain.size() < 2 and crits_dealt > 0:
		chain[entity] = true
		var target = ability_handler.find_target(entity.global_position, 9999, chain)
		if target:
			ability_handler.deal_damage(target)
			var particle_scale = ability_handler.get_attack_scale()
			get_node("/root/Main").particle_beam(get_node("/root/Main/Particles/Zap"), entity.global_position, target.global_position, 48, particle_scale, Config.get_team_color(ability_handler.owner.group, "secondary"))
			get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/Zap"), 4, target.global_position, particle_scale, Config.get_team_color(ability_handler.owner.group, "secondary"))
	chain.clear()
