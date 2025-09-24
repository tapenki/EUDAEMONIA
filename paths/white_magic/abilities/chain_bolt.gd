extends Ability

var inheritance_level = 1

var zap_scene = preload("res://paths/white_magic/zap.tscn")
var zapbeam_scene = preload("res://paths/white_magic/zapbeam.tscn")

var chain = {}

func _ready() -> void:
	ability_handler.crit_chance_modifiers.connect(crit_chance_modifiers)
	ability_handler.damage_dealt.connect(damage_dealt)

func crit_chance_modifiers(_entity, modifiers) -> void:
	modifiers["source"] += 10 * level

func damage_dealt(entity, _damage, crits_dealt) -> void:
	if crits_dealt > 0:
		var attack_scale = ability_handler.get_attack_scale({"source" : 0, "multiplier" : 0.5 + (0.5 * level), "flat" : 0})
		var reach = 160 * attack_scale
		chain[entity] = true
		var target = ability_handler.find_target(entity.global_position, reach, chain)
		if target:
			var crits = ability_handler.get_crits(target)
			var damage = ability_handler.get_damage_dealt(target, {"source" : 0, "multiplier": 1}, crits)
			ability_handler.damage_dealt.emit(target, damage, crits)
			target.take_damage(ability_handler.owner, damage)
			var particle_scale = ability_handler.get_attack_scale()
			get_node("/root/Main").particle_beam(zapbeam_scene, entity.global_position, target.global_position, 32, particle_scale, Config.get_team_color(ability_handler.owner.group, "secondary"))
			get_node("/root/Main").spawn_particles(zap_scene, target.global_position, particle_scale, Config.get_team_color(ability_handler.owner.group, "secondary"))
	chain.clear()
