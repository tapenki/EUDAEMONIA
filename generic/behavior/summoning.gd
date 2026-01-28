extends State

@export var summon: PackedScene
@export var summon_health: float = 1.0
@export var max_summons: int

@export var next: State

var summons: Array

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)

func on_enter() -> void:
	super()
	
	if summons.size() < max_summons:
		var summon_instance = user.ability_handler.make_summon(summon, 
		user.global_position, 
		2,
		user.max_health * summon_health)
		summon_instance.ability_handler.inherited_damage["multiplier"] = get_node("/root/Main").scale_enemy_damage()
		get_node("/root/Main/Entities").add_child(summon_instance)
		get_node("/root/Main/Entities").move_child(summon_instance, 0)
		summons.append(summon_instance)
	
	state_handler.change_state(next)

func entity_death(dying_entity: Entity):
	if summons.has(dying_entity):
		summons.erase(dying_entity)
	elif dying_entity == user:
		get_node("/root/Main").entity_death.disconnect(entity_death)
		for entity in summons:
			entity.kill()
