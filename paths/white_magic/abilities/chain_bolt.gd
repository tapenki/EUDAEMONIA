extends Ability

var inheritance_level = 1
var type = "Upgrade"

var zap_scene = preload("res://paths/white_magic/zap.tscn")
var zapbeam_scene = preload("res://paths/white_magic/zapbeam.tscn")

func _ready() -> void:
	ability_handler.attack_impact.connect(attack_impact)
	
func attack_impact(impact_position, body) -> void:
	var attack_scale = ability_handler.get_attack_scale({"source" : 0, "multiplier" : 0.5 + (0.5 * level), "flat" : 0})
	var reach = 160 * attack_scale
	var target = ability_handler.find_target(impact_position, reach, {body : true})
	if target:
		var crits = ability_handler.get_crits()
		var damage = ability_handler.get_damage_dealt(target, {"source" : 0, "multiplier": 1}, crits)
		ability_handler.damage_dealt.emit(target, damage)
		target.take_damage(ability_handler.owner, damage)
		var particle_scale = ability_handler.get_attack_scale()
		get_node("/root/Main").particle_beam(zapbeam_scene, impact_position, target.global_position, 32, particle_scale, Config.get_team_color(ability_handler.owner.group, "secondary"))
		get_node("/root/Main").spawn_particles(zap_scene, target.global_position, particle_scale, Config.get_team_color(ability_handler.owner.group, "secondary"))
