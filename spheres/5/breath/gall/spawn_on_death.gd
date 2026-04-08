extends Node2D

@export var ability_relay: Node

@export var summon: PackedScene
@export var summon_health = 1.0

func _ready() -> void:
	ability_relay.death_effects.connect(death_effects)

func death_effects():
	var summon_instance = ability_relay.make_summon(summon, 
	global_position, 
	{"subscription" = 2})
	summon_instance.max_health = ability_relay.owner.max_health * summon_health ## prevent necromanced enemies summons from having inflated stats
	summon_instance.health = summon_instance.max_health
	summon_instance.ability_relay.inherited_damage = ability_relay.inherited_damage.duplicate()#get_node("/root/Main").scale_enemy_damage()
	summon_instance.summoned = ability_relay.owner.summoned
	get_node("/root/Main/Entities").add_child(summon_instance)
