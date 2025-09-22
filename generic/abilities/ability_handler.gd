extends Node

@export var inherited_scale = {"source" : 0.0, "multiplier" : 1.0}
@export var inherited_damage = {"source" : 10.0, "multiplier" : 1.0}
@export var inherited_summon_damage = {"source" : 10.0, "multiplier" : 1.0}

@export var type: String

var speed_scale = 1.0

### signals
## stats signals
signal update_health()

## status signals
signal status_level_modifiers(status_name: String, modifiers: Dictionary)
signal status_applied(status: Node, levels: int)
signal update_status(status: Node)

## movement & speed signals
signal speed_scale_modifiers(modifiers: Dictionary)
signal move_speed_modifiers(modifiers: Dictionary)
signal movement(distance: float)

## attack signals
signal attack_rate_modifiers(modifiers: Dictionary)
signal attack_scale_modifiers(modifiers: Dictionary)
signal attack(direction: Vector2)
signal projectile_created(projectile: Projectile)

## summon signals
signal summon_damage_modifiers(modifiers: Dictionary)

## damage taken signals
signal damage_taken_modifiers(modifiers: Dictionary)
signal damage_taken(source, damage)
signal before_self_death(modifiers: Dictionary)
signal self_death()

## damage dealt signals
signal damage_dealt_modifiers(entity: Entity, modifiers: Dictionary)
signal damage_dealt_modifiers_no_inh(entity: Entity, modifiers: Dictionary)
signal damage_dealt(entity: Entity, damage)
signal attack_impact(position: Vector2, body: Node)

## misc signals
signal healed(amount)
signal upgraded(ability: Node)

### methods
func _physics_process(_delta: float) -> void:
	var modifiers = {"source" : 1.0, "multiplier" : 1}
	speed_scale_modifiers.emit(modifiers)
	speed_scale = modifiers["source"] * modifiers["multiplier"]

## stat getters
func get_move_speed(source: float):
	var modifiers = {"source" : source, "multiplier" : 1}
	move_speed_modifiers.emit(modifiers)
	return max(modifiers["source"] * modifiers["multiplier"], 0)

func get_attack_rate(source: float):
	var modifiers = {"source" : source, "multiplier" : 1}
	attack_rate_modifiers.emit(modifiers)
	return modifiers["source"] * modifiers["multiplier"]

func get_attack_scale(modifiers: Dictionary = {"source" : 0, "multiplier" : 1}):
	attack_scale_modifiers.emit(modifiers)
	return (1 + inherited_scale["source"] + modifiers["source"]) * inherited_scale["multiplier"] * modifiers["multiplier"]

func get_damage_dealt(entity: Entity, modifiers: Dictionary = {"source" : 0, "multiplier" : 1}):
	damage_dealt_modifiers.emit(entity, modifiers)
	damage_dealt_modifiers_no_inh.emit(entity, modifiers)
	return (inherited_damage["source"] + modifiers["source"]) * inherited_damage["multiplier"] * modifiers["multiplier"]

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
	var space_state = PhysicsServer2D.space_get_direct_state(get_node("/root/Main").physics_space)
	var shape_query = PhysicsShapeQueryParameters2D.new()
	shape_query.shape = CircleShape2D.new()
	shape_query.shape.radius = radius
	shape_query.transform = shape_query.transform.translated(position)
	shape_query.collision_mask = mask
	var intersections = space_state.intersect_shape(shape_query)
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
func make_projectile(projectile_scene: PackedScene, position: Vector2, inheritance: int, velocity = Vector2(), damage: Dictionary = {"source" : 0, "multiplier" : 1}, scale: Dictionary = {"source" : 0, "multiplier" : 1}, projectile_group = owner.group):
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.global_position = position
	projectile_instance.velocity = velocity
	
	get_node("/root/Main/").assign_projectile_group(projectile_instance, projectile_group)
	
	inherit(projectile_instance.ability_handler, inheritance)
	
	attack_scale_modifiers.emit(scale)
	scale["source"] += inherited_scale["source"]
	scale["multiplier"] *= inherited_scale["multiplier"]
	projectile_instance.ability_handler.inherited_scale = scale
	
	damage_dealt_modifiers.emit(null, damage)
	damage["source"] += inherited_damage["source"]
	damage["multiplier"] *= inherited_damage["multiplier"]
	projectile_instance.ability_handler.inherited_damage = damage
	
	projectile_created.emit(projectile_instance)
	return projectile_instance

func make_summon(summon_scene: PackedScene, position: Vector2, inheritance: int, health: int, damage: Dictionary = {"source" : 0, "multiplier" : 1}, summon_group = owner.group):
	var summon_instance = summon_scene.instantiate()
	summon_instance.global_position = position
	
	get_node("/root/Main/").assign_entity_group(summon_instance, summon_group)
	summon_instance.summoned = true
	
	summon_instance.max_health = health
	summon_instance.health = health
	
	var summon_damage = inherited_summon_damage.duplicate()
	summon_damage_modifiers.emit(summon_damage)
	summon_instance.ability_handler.inherited_summon_damage = damage
	
	damage["source"] += summon_damage["source"]
	damage["multiplier"] *= summon_damage["multiplier"]
	summon_instance.ability_handler.inherited_damage = damage
	
	inherit(summon_instance.ability_handler, inheritance)
	return summon_instance

## ability manipulation
func get_ranks():
	var ranks: Dictionary
	for ability in get_children():
		if ability.type == "Upgrade":
			for aspect in ability.aspects:
				if ranks.has(aspect):
					ranks[aspect] += ability.aspects[aspect] * ability.level
				else:
					ranks[aspect] = ability.aspects[aspect] * ability.level
	return ranks

func grant(script: Script, ability: String, levels: int):
	var ability_node = get_node_or_null(ability)
	if ability_node:
		ability_node.add_level(levels)
	else:
		ability_node = Node2D.new()
		ability_node.set_script(script)
		ability_node.level = levels
		ability_node.name = ability
		add_child(ability_node)
		update_status.emit(ability_node)
	return ability_node

func upgrade(script: Script, ability: String, levels: int):
	var ability_node = get_node_or_null(ability)
	if ability_node:
		ability_node.level += levels
	else:
		ability_node = Node2D.new()
		ability_node.set_script(script)
		ability_node.level = levels
		ability_node.name = ability
		add_child(ability_node)
	upgraded.emit(ability_node)

func apply_status(handler: Node, script: Script, ability: String, levels: int):
	var modifiers = {"source" : levels, "multiplier" : 1}
	status_level_modifiers.emit(ability, modifiers)
	levels = modifiers["source"] * modifiers["multiplier"]
	var status = handler.grant(script, ability, levels)
	status_applied.emit(status, levels)
	return status

func clear(ability: String, levels: int):
	var ability_node = get_node_or_null(ability)
	if ability_node:
		ability_node.add_level(-levels)

func inherit(handler: Node, inherit_level: int):
	for child in get_children():
		if child.inheritance_level < inherit_level:
			handler.grant(child.script, child.name, child.level)

## misc
func recover():
	owner.health = owner.max_health
	for ability in get_children():
		if ability.type == "Status":
			ability.clear()
	update_health.emit()
