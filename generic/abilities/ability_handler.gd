extends Node

@export var inherited_scale = {"source" : 0.0, "multiplier" : 1.0}
@export var inherited_damage = {"source" : 10.0, "multiplier" : 1.0}
@export var inherited_summon_damage = {"source" : 10.0, "multiplier" : 1.0}
@export var inherited_crit_chance = {"source" : 0.0, "multiplier" : 1.0}
@export var inherited_speed_scale = {"source" : 1.0, "multiplier" : 1.0}

@export_enum("entity", "projectile", "static") var type: String

var speed_scale = 1.0

### signals
## health signals
signal max_health_modifiers(modifiers: Dictionary)
signal update_health()
signal healed(amount: float)

## status signals
signal status_level_modifiers(status_name: String, modifiers: Dictionary)
signal status_applied(status: Node, levels: int)
#signal update_status(status: Node)

## movement & speed signals
signal inh_speed_scale_modifiers(modifiers: Dictionary)
signal move_speed_modifiers(modifiers: Dictionary)
signal movement(distance: float)

## attack signals
#signal attack_rate_modifiers(modifiers: Dictionary)
signal attack_scale_modifiers(modifiers: Dictionary)
signal attack(direction: Vector2)
#signal projectile_created(projectile: Projectile)
#signal attack_impact(position: Vector2, body: Node)

## summon signals
signal summon_damage_modifiers(modifiers: Dictionary)

## damage taken signals
signal damage_taken_modifiers(modifiers: Dictionary)
signal immune_duration_modifiers(modifiers: Dictionary)
signal damage_taken(source: Node, amount: float)
signal before_self_death(modifiers: Dictionary)
signal self_death()

## damage dealt signals
signal damage_dealt_modifiers(entity: Entity, modifiers: Dictionary, crits: int)
signal crit_chance_modifiers(entity: Entity, modifiers: Dictionary)
signal damage_dealt(entity: Entity, amount: float, crits: int)

## misc signals
signal upgraded()

### methods
func _physics_process(_delta: float) -> void:
	var modifiers = {"source" : 0, "multiplier" : 1}
	inh_speed_scale_modifiers.emit(modifiers)
	speed_scale = (inherited_speed_scale["source"] + modifiers["source"]) * inherited_speed_scale["multiplier"] * modifiers["multiplier"]

## stat getters
func get_health(health: float, max_health: float):
	var modifiers = {"source" : max_health, "multiplier" : 1}
	max_health_modifiers.emit(modifiers)
	var final_max_health = modifiers["source"] * modifiers["multiplier"]
	var final_health = final_max_health - max_health + health
	return {"health" : final_health, "max_health" : final_max_health}

func get_immune_duration(modifiers: Dictionary = {"source" : 0, "multiplier" : 1}):
	immune_duration_modifiers.emit(modifiers)
	return modifiers["source"] * modifiers["multiplier"]

func get_move_speed(source: float):
	var modifiers = {"source" : source, "multiplier" : 1}
	move_speed_modifiers.emit(modifiers)
	return max(modifiers["source"] * modifiers["multiplier"], 0)

#func get_attack_rate(source: float):
#	var modifiers = {"source" : source, "multiplier" : 1}
#	attack_rate_modifiers.emit(modifiers)
#	return modifiers["source"] * modifiers["multiplier"]

func get_attack_scale(modifiers: Dictionary = {"source" : 0, "multiplier" : 1}):
	attack_scale_modifiers.emit(modifiers)
	return (1 + inherited_scale["source"] + modifiers["source"]) * inherited_scale["multiplier"] * modifiers["multiplier"]

func get_damage_dealt(entity: Entity = null, modifiers: Dictionary = {"source" : 0, "multiplier" : 1}, crits: int = 0):
	damage_dealt_modifiers.emit(entity, modifiers, crits)
	if entity:
		entity.ability_handler.damage_taken_modifiers.emit(modifiers)
	return (inherited_damage["source"] + modifiers["source"]) * inherited_damage["multiplier"] * modifiers["multiplier"] * (1 + crits)

func get_crits(entity: Entity = null, modifiers: Dictionary = {"source" : 0, "multiplier" : 1}):
	crit_chance_modifiers.emit(entity, modifiers)
	var crit_chance = int((modifiers["source"] + inherited_crit_chance["source"]) * modifiers["multiplier"] * inherited_crit_chance["multiplier"])
	var leftover = crit_chance % 100
	var crits = (int)((crit_chance - leftover) * 0.01)
	if randi_range(1, 101) <= leftover:
		crits += 1
	return crits

func deal_damage(entity: Entity, damage: Dictionary = {"source" : 0, "multiplier" : 1}):
	var crits = get_crits(entity)
	var final_damage = get_damage_dealt(entity, damage, crits)
	damage_dealt.emit(entity, final_damage, crits)
	var damaged = entity.take_damage(self, final_damage)
	if damaged:
		var damage_color = Config.get_team_color(owner.group, "secondary")
		get_node("/root/Main").floating_text(entity.global_position + Vector2(randi_range(-16, 16), -16 + randi_range(-16, 16)), str(int(final_damage)), damage_color)
	return {"damage" : final_damage, "crits" : crits}

## targeting
func get_enemy_group():
	if owner.group == 1:
		return 2
	return 1

func can_hit(entity: Entity):
	return entity.group != owner.group and entity.alive

func enemies_mask():
	var mask = 0
	for i in range(1, 3):
		if i != owner.group:
			mask += pow(2, i-1);
	return mask

func area_targets(position: Vector2, radius = 9999, mask = enemies_mask()):
	var space_state = get_node("/root/Main").physics_space
	var shape_query = PhysicsShapeQueryParameters2D.new()
	shape_query.shape = CircleShape2D.new()
	shape_query.shape.radius = radius
	shape_query.transform = shape_query.transform.translated(position)
	shape_query.collision_mask = mask
	var intersections = space_state.intersect_shape(shape_query, 128)
	var returned: Array
	for i in intersections:
		var entity = i.get("collider")
		if entity.alive:
			returned.append(entity)
	return returned

func find_target(position = owner.global_position, reach = 9999, exclude = {}):
	var found
	for entity in area_targets(position, reach):
		if entity != owner and not exclude.has(entity):
			var distance = position.distance_to(entity.global_position)
			if distance < reach:
				reach = distance
				found = entity
	return found

## instancing
func make_projectile(projectile_scene: PackedScene, position: Vector2, inheritance: int, velocity = Vector2(), projectile_group = owner.group):
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.global_position = position
	projectile_instance.velocity = velocity
	
	get_node("/root/Main/").assign_projectile_group(projectile_instance, projectile_group)
	
	var scale = inherited_scale.duplicate()
	projectile_instance.ability_handler.inherited_scale = scale
	
	var damage = inherited_damage.duplicate()
	projectile_instance.ability_handler.inherited_damage = damage
	
	var crit_chance = inherited_crit_chance.duplicate()
	#inh_crit_chance_modifiers.emit(crit_chance)
	projectile_instance.ability_handler.inherited_crit_chance = crit_chance
	
	var speed = inherited_speed_scale.duplicate()
	inh_speed_scale_modifiers.emit(speed)
	projectile_instance.ability_handler.inherited_speed_scale = speed
	
	inherit(projectile_instance.ability_handler, inheritance)
	#projectile_created.emit(projectile_instance)
	return projectile_instance

func make_summon(summon_scene: PackedScene, position: Vector2, inheritance: int, health: int, summon_group = owner.group):
	var summon_instance = summon_scene.instantiate()
	summon_instance.global_position = position
	
	get_node("/root/Main/").assign_entity_group(summon_instance, summon_group)
	summon_instance.summoned = true
	
	summon_instance.max_health = health
	summon_instance.health = health
	
	var summon_damage = inherited_summon_damage.duplicate()
	summon_damage_modifiers.emit(summon_damage)
	summon_instance.ability_handler.inherited_damage = summon_damage
	
	inherit(summon_instance.ability_handler, inheritance)
	return summon_instance

## ability manipulation
func grant(ability: String, levels: int):
	var ability_node = get_node_or_null(ability)
	if ability_node:
		ability_node.add_level(levels)
	else:
		ability_node = Node2D.new()
		ability_node.set_script(AbilityData.ability_data[ability]["script"])
		ability_node.level = levels
		ability_node.name = ability
		add_child(ability_node)
		#update_status.emit(ability_node)
	return ability_node

func upgrade(ability: String, levels: int):
	var ability_node = get_node_or_null(ability)
	if ability_node:
		ability_node.level += levels
		update_health.emit()
	else:
		ability_node = Node2D.new()
		ability_node.set_script(AbilityData.ability_data[ability]["script"])
		ability_node.level = levels
		ability_node.name = ability
		add_child(ability_node)
	upgraded.emit()

func apply_status(handler: Node, ability: String, levels: int):
	var modifiers = {"source" : levels, "multiplier" : 1}
	status_level_modifiers.emit(ability, modifiers)
	levels = modifiers["source"] * modifiers["multiplier"]
	var status = handler.grant(ability, levels)
	status_applied.emit(status, levels)
	return status

func clear(ability: String, levels: int):
	var ability_node = get_node_or_null(ability)
	if ability_node:
		ability_node.add_level(-levels)

func inherit(handler: Node, inherit_level: int):
	for child in get_children():
		child.inherit(handler, inherit_level)

## misc
func recover():
	owner.health = owner.max_health
	for ability in get_children():
		if AbilityData.ability_data[ability.name]["type"] == "status":
			ability.clear()
	update_health.emit()
