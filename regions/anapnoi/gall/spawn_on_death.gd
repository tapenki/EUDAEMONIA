extends Node2D

@export var ability_handler: Node

@export var summon: PackedScene
@export var summon_health = 1.0

func _ready() -> void:
	ability_handler.death_effects.connect(death_effects)

func death_effects():
	var summon_instance = ability_handler.make_summon(summon, 
	global_position, 
	2,
	ability_handler.owner.max_health * summon_health)
	summon_instance.ability_handler.inherited_damage["multiplier"] = get_node("/root/Main").scale_enemy_damage()
	summon_instance.summoned = ability_handler.owner.summoned
	get_node("/root/Main/Entities").add_child(summon_instance)
