extends Node2D

@export var ability_handler: Node

@export var entity_scene = preload("res://regions/thayma/debree/debree.tscn")
@export var count: int

func _ready() -> void:
	for repeat in count:
		var entity_instance = ability_handler.make_summon(entity_scene, 
		Vector2(),
		3,
		-1)
		entity_instance.max_health = get_node("/root/Main").scale_enemy_health(entity_instance.max_health)
		entity_instance.health = entity_instance.max_health
		add_child(entity_instance)
		entity_instance.ability_handler.inherited_damage["multiplier"] = get_node("/root/Main").scale_enemy_damage()
	ability_handler.self_death.connect(self_death)

func self_death():
	for debree in get_children():
		debree.loosen()
