extends Ability

var inheritance_level = 3

var quills_scene = preload("res://paths/black_magic/quills.tscn")

func _ready() -> void:
	ability_handler.damage_taken.connect(damage_taken)
	
func damage_taken(_source, _damage) -> void:
	var attack_scale = ability_handler.get_attack_scale({"source" : 0, "multiplier" : 1.5})
	var reach = 80 * attack_scale
	for entity in ability_handler.area_targets(global_position, reach):
		var crits = ability_handler.get_crits()
		var damage = ability_handler.get_damage_dealt(entity, {"source" : 0, "multiplier" : 2 * level}, crits)
		ability_handler.damage_dealt.emit(entity, damage)
		entity.take_damage(ability_handler.owner, damage)
	get_node("/root/Main").spawn_particles(quills_scene, global_position, attack_scale, Config.get_team_color(ability_handler.owner.group, "secondary"))
