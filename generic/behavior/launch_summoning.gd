extends State

@export var summon: PackedScene
@export var summon_health: float = 1.0
@export var summon_count: int = 1
@export var max_summons: int

@export var knockback_speed: int
@export var knockback_duration: float
@export var spread: int

@export var next: State

func _ready() -> void:
	if not state_handler.data.has("summons"):
		state_handler.data["summons"] = []
		get_node("/root/Main").entity_death.connect(entity_death)

func on_enter() -> void:
	super()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_relay.find_target()
	if is_instance_valid(state_handler.target):
		state_handler.data["direction"] = user.global_position.direction_to(state_handler.target.global_position)
	else:
		state_handler.data["direction"] = Vector2()
	
	var to_summon = min(summon_count, max_summons - state_handler.data["summons"].size())
	if to_summon <= 0:
		change_state(next)
		return
	
	var velocity = state_handler.data["direction"] * knockback_speed
	var stepsize = deg_to_rad(spread) / (to_summon - 1)
	var halfspan = deg_to_rad(spread) * 0.5
	if to_summon == 1:
		stepsize = 0
		halfspan = 0
	for i in to_summon:
		var summon_instance = user.ability_relay.make_summon(summon, 
		user.global_position, 
		{"subscription" = 2, "innate_summon" = true})
		summon_instance.max_health = user.max_health * summon_health ## prevent necromanced enemies summons from having inflated stats
		summon_instance.health = summon_instance.max_health
		summon_instance.ability_relay.inherited_damage = user.ability_relay.inherited_damage.duplicate()#get_node("/root/Main").scale_enemy_damage()
		get_node("/root/Main/Entities").add_child(summon_instance)
		get_node("/root/Main/Entities").move_child(summon_instance, 0)
		state_handler.data["summons"].append(summon_instance)
		summon_instance.velocity += velocity.rotated(halfspan - (stepsize * i))
		summon_instance.knockback_timer.start(knockback_duration)
	
	change_state(next)

func entity_death(dying_entity: Entity):
	if state_handler.data["summons"].has(dying_entity):
		state_handler.data["summons"].erase(dying_entity)
	elif dying_entity == user:
		get_node("/root/Main").entity_death.disconnect(entity_death)
		for entity in state_handler.data["summons"]:
			entity.kill()
