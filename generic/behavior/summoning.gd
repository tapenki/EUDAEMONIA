extends State

@export var summon: PackedScene
@export var summon_health: float = 1.0
@export var max_summons: int

@export var next: State

func _ready() -> void:
	if not state_handler.data.has("summons"):
		state_handler.data["summons"] = []
		get_node("/root/Main").entity_death.connect(entity_death)

func on_enter() -> void:
	super()
	
	if state_handler.data["summons"].size() < max_summons:
		var summon_instance = user.ability_relay.make_summon(summon, 
		user.global_position, 
		{"subscription" = 2})
		summon_instance.max_health = user.max_health * summon_health ## prevent necromanced enemies summons from having inflated stats
		summon_instance.health = summon_instance.max_health
		summon_instance.ability_relay.inherited_damage = user.ability_relay.inherited_damage.duplicate()#get_node("/root/Main").scale_enemy_damage()
		get_node("/root/Main/Entities").add_child(summon_instance)
		get_node("/root/Main/Entities").move_child(summon_instance, 0)
		state_handler.data["summons"].append(summon_instance)
	
	state_handler.change_state(next)

func entity_death(dying_entity: Entity):
	if state_handler.data["summons"].has(dying_entity):
		state_handler.data["summons"].erase(dying_entity)
	elif dying_entity == user:
		get_node("/root/Main").entity_death.disconnect(entity_death)
		for entity in state_handler.data["summons"]:
			entity.kill()
