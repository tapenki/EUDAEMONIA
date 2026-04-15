extends Node

@export var inherited_scale = {"base" : 0.0, "multiplier" : 1.0}
@export var inherited_damage = {"base" : 10.0, "multiplier" : 1.0}
@export var inherited_summon_damage = {"base" : 10.0, "multiplier" : 1.0}
@export var inherited_crit_chance = {"base" : 0.0, "multiplier" : 1.0}
#@export var inherited_speed_scale = {"base" : 1.0, "multiplier" : 1.0}

@export var is_entity: bool
@export var is_projectile: bool

var ability_handler: Node
var applied_abilities: Dictionary

var source: Node
var entity_source: Node

var speed_scale = 1.0

### signals
## health signals
signal max_health_modifiers(modifiers: Dictionary)
signal heal_modifiers(modifiers: Dictionary)
signal healed(amount: float)

## movement & speed signals
signal speed_scale_modifiers(modifiers: Dictionary)
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
signal crit_taken_modifiers(modifiers: Dictionary)
signal immune_duration_modifiers(modifiers: Dictionary)
signal damage_taken(damage: Dictionary)
signal before_self_death(modifiers: Dictionary)
signal death_effects()
signal self_death()
signal freed()

## damage dealt signals
signal damage_dealt_modifiers(entity: Entity, modifiers: Dictionary)
signal crit_chance_modifiers(entity: Entity, modifiers: Dictionary)
signal damage_dealt(entity: Entity, damage: Dictionary)

## misc signals
signal hits_left_modifiers(modifiers: Dictionary)

### methods
func _physics_process(_delta: float) -> void:
	var modifiers = {"base" : 1, "multiplier" : 1.0}
	speed_scale_modifiers.emit(modifiers)
	speed_scale = modifiers["base"] * modifiers["multiplier"]

func _ready() -> void:
	if not source:
		source = self
	if not entity_source and is_entity:
		entity_source = self

## stat getters
func get_health(health = owner.health, max_health = owner.max_health):
	var modifiers = {"base" : max_health, "multiplier" : 1}
	max_health_modifiers.emit(modifiers)
	var final_max_health = modifiers["base"] * modifiers["multiplier"]
	var final_health = final_max_health - max_health + health
	return {"health" : final_health, "max_health" : final_max_health}

func get_hits_left(hits_left = owner.hits_left):
	var modifiers = {"base" : hits_left, "multiplier" : 1}
	hits_left_modifiers.emit(modifiers)
	return int(modifiers["base"] * modifiers["multiplier"])

func get_immune_duration(modifiers: Dictionary = {"base" : 0, "multiplier" : 1}):
	immune_duration_modifiers.emit(modifiers)
	return modifiers["base"] * modifiers["multiplier"]

func get_move_speed(base: float):
	var modifiers = {"base" : base, "multiplier" : 1}
	move_speed_modifiers.emit(modifiers)
	return max(modifiers["base"] * modifiers["multiplier"], 0)

#func get_attack_rate(source: float):
#	var modifiers = {"base" : source, "multiplier" : 1}
#	attack_rate_modifiers.emit(modifiers)
#	return modifiers["base"] * modifiers["multiplier"]

func get_attack_scale(modifiers: Dictionary = {"base" : 0, "multiplier" : 1}):
	attack_scale_modifiers.emit(modifiers)
	return (1 + inherited_scale["base"] + modifiers["base"]) * inherited_scale["multiplier"] * modifiers["multiplier"]

func get_damage_dealt(entity: Entity = null, damage: Dictionary = {"base" : 0, "multiplier" : 1}):
	if not damage.has("skip_output_modifiers"):
		damage["base"] += inherited_damage["base"]
		damage["multiplier"] *= inherited_damage["multiplier"]
		damage_dealt_modifiers.emit(entity, damage)
	if entity and not damage.has("skip_input_modifiers"):
		entity.ability_relay.damage_taken_modifiers.emit(damage)
	damage["final"] = damage["base"] * damage["multiplier"]
	if damage.has("crits"):
		damage["final"] *= pow(1.5, damage["crits"])

func get_crits(entity: Entity = null, crit: Dictionary = {"base" : 0, "multiplier" : 1}, skip_input_modifiers = false, skip_output_modifiers = false):
	if not skip_output_modifiers:
		crit["base"] += inherited_crit_chance["base"]
		crit["multiplier"] *= inherited_crit_chance["multiplier"]
		crit_chance_modifiers.emit(entity, crit)
	if entity and not skip_input_modifiers:
		entity.ability_relay.crit_taken_modifiers.emit(crit)
	var crit_chance = int(crit["base"] * crit["multiplier"])
	var crits = 0
	if randi() % 100 < crit_chance:
		crits += 1
	return crits

func deal_damage(entity: Entity, damage: Dictionary = {"base" : 0, "multiplier" : 1, "direction" : Vector2()}, damage_color = Config.get_team_color(owner.group, "secondary")):
	damage["group"] = owner.group
	if entity.health == entity.max_health:
		damage["first_blood"] = true
	var crits = get_crits(entity, {"base" : 0, "multiplier" : 1}, damage.has("skip_input_modifiers"), damage.has("skip_output_modifiers"))
	damage["crits"] = crits
	get_damage_dealt(entity, damage)
	var damaged = entity.take_damage(damage)
	if damaged:
		if not damage.has("skip_output_modifiers"):
			damage_dealt.emit(entity, damage)
		var damage_text = str(int(damage["final"]))
		if damage["crits"] > 0:
			damage_text += "!".repeat(damage["crits"])
		get_node("/root/Main").floating_text(entity.global_position + Vector2(randi_range(-16, 16), -16 + randi_range(-16, 16)), damage_text, damage_color)
	#if damage.has("direction"):
	#	apply_knockback(entity, damage["direction"])
	return damage

#func apply_knockback(entity: Entity, direction: Vector2, intensity = 1.0):
	#intensity *= entity.knockback_affect
	#if intensity == 0:
		#return
	#var duration = 0.05*intensity
	#if entity.knockback_timer.time_left < duration:
		#entity.knockback_timer.start(duration)
	#var knockback_velocity = direction * 900 * (1 - pow(0.5, intensity))
	#var max_length = max(knockback_velocity.length(), entity.velocity.length())
	#entity.velocity += knockback_velocity * (entity.velocity - knockback_velocity).limit_length(max_length).length()/max_length

func roll_chance(odds: Dictionary):
	var final_chance = odds["base"] * odds["multiplier"]
	var result = floor(final_chance / 100)
	var rolls = 1
	for i in rolls:
		if randf() * 100 < fmod(final_chance, 100):
			result += 1
			break
	return result

func accumulate_damage(damage: Dictionary):
	var accumulated_damage = damage["final"]
	if damage.has("crits"):
		accumulated_damage *= pow(1.5, damage["crits"])
	return accumulated_damage

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
		if entity != owner and not exclude.has(entity) and not entity.unchaseable:
			var distance = position.distance_to(entity.global_position)
			if distance < reach:
				reach = distance
				found = entity
	return found

## instantiation
# can't get main from outside the tree
func assign_projectile_group(projectile: Projectile, group: int, color: String = "secondary"):
	projectile.group = group
	for i in range(1, 3):
			projectile.set_collision_mask_value(i, i != group)
	projectile.set_collision_layer_value(group, true)
	projectile.apply_palette(group, color)

func assign_entity_group(entity: Entity, group: int, color: String = "secondary"):
	entity.group = group
	var hurtbox = entity.get_node_or_null("Hurtbox")
	if hurtbox:
		for i in range(1, 3):
			hurtbox.set_collision_mask_value(i, i != group)
	entity.set_collision_layer_value(group, true)
	entity.apply_palette(group, color)

func make_projectile(projectile_scene: PackedScene, position: Vector2, applicant_data: Dictionary, velocity = Vector2(), projectile_group = owner.group):
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.global_position = position
	projectile_instance.velocity = velocity
	
	assign_projectile_group(projectile_instance, projectile_group)
	
	projectile_instance.ability_relay.source = self
	if is_entity:
		projectile_instance.ability_relay.entity_source = self
	elif is_instance_valid(entity_source):
		projectile_instance.ability_relay.entity_source = entity_source
	
	var scale = inherited_scale.duplicate()
	projectile_instance.ability_relay.inherited_scale = scale
	
	var damage = inherited_damage.duplicate()
	projectile_instance.ability_relay.inherited_damage = damage
	
	var crit_chance = inherited_crit_chance.duplicate()
	#inh_crit_chance_modifiers.emit(crit_chance)
	projectile_instance.ability_relay.inherited_crit_chance = crit_chance
	
	if ability_handler:
		ability_handler.subscribe(projectile_instance.ability_relay, applicant_data)
	#projectile_created.emit(projectile_instance)
	return projectile_instance

func make_summon(summon_scene: PackedScene, position: Vector2, applicant_data: Dictionary, summon_group = owner.group):
	var summon_instance = summon_scene.instantiate()
	summon_instance.global_position = position
	
	assign_entity_group(summon_instance, summon_group)
	summon_instance.summoned = true
	
	summon_instance.ability_relay.source = self
	if is_entity:
		summon_instance.ability_relay.entity_source = self
	elif is_instance_valid(entity_source):
		summon_instance.ability_relay.entity_source = entity_source
	
	var summon_damage = inherited_summon_damage.duplicate()
	summon_damage_modifiers.emit(summon_damage)
	summon_instance.ability_relay.inherited_damage = summon_damage
	
	if ability_handler:
		ability_handler.subscribe(summon_instance.ability_relay, applicant_data)
	return summon_instance
