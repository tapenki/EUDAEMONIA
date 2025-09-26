extends Ability

var inheritance_level = 4

@export var entity_scene = preload("res://spheres/aporia/debree/debree.tscn")

func _ready() -> void:
	for repeat in level:
		var entity_instance = ability_handler.make_summon(entity_scene, 
		Vector2(),
		3,
		get_node("/root/Main").scale_enemy_health(40))
		add_child(entity_instance)

func kill():
	for debree in get_children():
		debree.loosen()
	super()
