extends Ability

var soul_tether: bool
var preserved_elite: String

func apply(ability_relay, applicant_data):
	if applicant_data.has("army_of_the_dead"):
		applicant_data["base_hp"] = ability_relay.owner.max_health
		ability_relay.max_health_modifiers.connect(max_health_modifiers.bind(ability_relay))
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("army_of_the_dead"):
		applicant_data["army_of_the_dead"] = applicants[ability_relay.source]["army_of_the_dead"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	get_node("/root/Main").day_start.connect(day_start)

func entity_death(dying_entity: Entity):
	for ability_relay in applicants:
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 5:
			return
		if dying_entity.group == ability_relay.get_enemy_group() and not dying_entity.summoned:
			var summon_instance = ability_relay.make_summon(load(dying_entity.scene_file_path), 
			dying_entity.global_position,
			{"subscription" = 2, "army_of_the_dead" = true})  ## inheritance
			if summon_instance.max_health > 100:
				preserved_elite = dying_entity.scene_file_path
			summon_instance.max_health = 0
			summon_instance.health = 0
			get_node("/root/Main").spawn_entity(summon_instance)

func day_start(_day: int) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 5:
			return
		if soul_tether and preserved_elite:
			var summon_instance = ability_relay.make_summon(load(preserved_elite), 
			ability_relay.global_position,
			{"subscription" = 2, "army_of_the_dead" = true})  ## inheritance
			summon_instance.max_health = 0
			summon_instance.health = 0
			summon_instance.global_position = summon_instance.random_valid_position(get_node("/root/Main").room_node.get_node("TileMap"))
			get_node("/root/Main").spawn_entity(summon_instance)

func max_health_modifiers(modifiers, ability_relay) -> void:
	modifiers["base"] += applicants[ability_relay]["base_hp"] * 0.75 * level

func damage_dealt_modifiers(_entity, damage) -> void:
	damage["base"] += 3 * level - 3

func serialize():
	return {"level" : level, "preserved_elite" : preserved_elite}

func deserialize(data):
	level = data["level"]
	preserved_elite = data["preserved_elite"]
