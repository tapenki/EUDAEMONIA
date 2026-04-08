extends Node2D

@export var ability_relay: Node

@export var entity_scene = preload("res://spheres/3/wonder/debree/debree.tscn")
@export var count: int
@export var summon_health: float = 1.0

func _ready() -> void:
	for repeat in count:
		var entity_instance = ability_relay.make_summon(entity_scene, 
		Vector2(),
		{"subscription" = 2})
		entity_instance.max_health = ability_relay.owner.max_health * summon_health
		entity_instance.health = entity_instance.max_health
		add_child(entity_instance)
		entity_instance.ability_relay.inherited_damage["multiplier"] = get_node("/root/Main").scale_enemy_damage()
	ability_relay.self_death.connect(self_death)

func self_death():
	for debree in get_children():
		debree.loosen()
