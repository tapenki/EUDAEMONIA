extends Ability

@export var summon_scene = preload("res://paths/death/bone_shield/bone_shield.tscn")

var osteophalanx: bool

var status: Node

func apply(ability_relay, applicant_data):
	if applicant_data.has("bone_shield"):
		ability_relay.max_health_modifiers.connect(max_health_modifiers)
		ability_relay.damage_dealt.connect(damage_dealt)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("bone_shield"):
		applicant_data["bone_shield"] = applicants[ability_relay.source]["bone_shield"]
		ability_relay.damage_dealt.connect(damage_dealt)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	if applicants.has(ability_relay) and applicants[ability_relay].has("bone_shields"):
		for shield in applicants[ability_relay]["bone_shields"]:
			if is_instance_valid(shield):
				shield.ability_relay.freed.emit()
				shield.queue_free()
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)
	if ability_relay.damage_dealt.is_connected(damage_dealt):
		ability_relay.damage_dealt.disconnect(damage_dealt)

func _ready() -> void:
	status = ability_handler.learn("chill", 0)
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").intermission.connect(intermission)

func day_start(_day: int) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 5:
			return
		if osteophalanx:
			var summon_instance1 = ability_relay.make_summon(summon_scene, 
			Vector2(),
			{"subscription" = 2, "bone_shield" = true})
			summon_instance1.distance = 75
			ability_relay.add_child(summon_instance1)
			var summon_instance2 = ability_relay.make_summon(summon_scene, 
			Vector2(),
			{"subscription" = 2, "bone_shield" = true})
			summon_instance2.distance = 50
			summon_instance2.angle = PI * 0.25
			ability_relay.add_child(summon_instance2)
			var summon_instance3 = ability_relay.make_summon(summon_scene, 
			Vector2(),
			{"subscription" = 2, "bone_shield" = true})
			summon_instance3.distance = 50
			summon_instance3.angle = -PI * 0.25
			ability_relay.add_child(summon_instance3)
			var summon_instance4 = ability_relay.make_summon(summon_scene, 
			Vector2(),
			{"subscription" = 2, "bone_shield" = true})
			summon_instance4.distance = 50
			summon_instance4.scale *= 1.5
			ability_relay.add_child(summon_instance4)
			applicants[ability_relay]["bone_shields"] = [summon_instance1, summon_instance2, summon_instance3, summon_instance4]
		else:
			var summon_instance = ability_relay.make_summon(summon_scene, 
			Vector2(),
			{"subscription" = 2, "bone_shield" = true})
			summon_instance.distance = 50
			summon_instance.scale *= 1.25
			ability_relay.add_child(summon_instance)
			applicants[ability_relay]["bone_shields"] = [summon_instance]
		
func intermission(_day: int) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("bone_shields"):
			for shield in applicants[ability_relay]["bone_shields"]:
				if is_instance_valid(shield):
					shield.ability_relay.freed.emit()
					shield.queue_free()
					

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += 60 * level

func damage_dealt(entity, _damage) -> void:
	status.apply(entity.ability_relay, {"duration" = 0.3})
