extends Ability

var chain = {}

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)
	ability_relay.damage_dealt.connect(damage_dealt.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.crit_chance_modifiers.is_connected(crit_chance_modifiers):
		ability_relay.crit_chance_modifiers.disconnect(crit_chance_modifiers)
	if ability_relay.damage_dealt.is_connected(damage_dealt):
		ability_relay.damage_dealt.disconnect(damage_dealt)

func crit_chance_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 5 * level

func damage_dealt(entity, damage, ability_relay) -> void:
	var max_chains = level
	if chain.size() < max_chains and damage.get("crits", 0) > 0:
		chain[entity] = true
		var target = ability_relay.find_target(entity.global_position, 9999, chain)
		if target:
			ability_relay.deal_damage(target, {"base" : 0, "multiplier" : 1, "direction" : entity.global_position.direction_to(target.global_position)})
			var particle_scale = 1.0#ability_relay.get_attack_scale()
			get_node("/root/Main").particle_beam(get_node("/root/Main/Particles/Zap"), entity.global_position, target.global_position, 48, particle_scale, Config.get_team_color(ability_relay.owner.group, "secondary"))
			get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/Zap"), 4, target.global_position, particle_scale, Config.get_team_color(ability_relay.owner.group, "secondary"))
	chain.clear()
