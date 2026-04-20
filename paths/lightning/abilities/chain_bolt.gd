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
	var max_chains = 2#level
	if chain.size() < max_chains and damage.get("crits", 0) > 0:
		chain[entity] = true
		var target = ability_relay.find_target(entity.global_position, 9999, chain)
		if target:
			ability_relay.deal_damage(target)
			var particle_scale = 1#1.2#ability_relay.get_attack_scale()
			get_node("/root/Main/ParticleHandler").particle_beam("common", 
			preload("res://paths/lightning/zap.png"),
			entity.global_position,
			target.global_position,
			particle_scale,
			32,
			Config.get_team_color(ability_relay.owner.group, "secondary"))
			get_node("/root/Main/ParticleHandler").quick_particles("impact", 
			preload("res://paths/lightning/zap.png"),
			target.global_position,
			particle_scale,
			4,
			Config.get_team_color(ability_relay.owner.group, "secondary"))
	chain.clear()
