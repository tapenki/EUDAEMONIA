extends Ability

var explosion_scene = preload("res://paths/death/harvest_explosion/harvest_explosion.tscn")

var status: Node

var bad_crop: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("dark_harvest"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
		ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers)
		ability_relay.damage_dealt.connect(damage_dealt.bind(ability_relay))
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("dark_harvest"):
		applicant_data["dark_harvest"] = applicants[ability_relay.source]["dark_harvest"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
		ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers)
		ability_relay.damage_dealt.connect(damage_dealt.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.attack_scale_modifiers.is_connected(attack_scale_modifiers):
		ability_relay.attack_scale_modifiers.disconnect(attack_scale_modifiers)
	if ability_relay.damage_dealt.is_connected(damage_dealt):
		ability_relay.damage_dealt.disconnect(damage_dealt)

func _ready() -> void:
	status = ability_handler.learn("doom", 0)

func _unhandled_input(event: InputEvent) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 5:
			return
		if Input.is_action_just_pressed("dark_harvest") and event.is_action("dark_harvest"):
			var target
			var to_target = INF
			for entity in ability_relay.area_targets(ability_relay.get_global_mouse_position(), 9999, pow(2, ability_relay.owner.group-1)):
				if entity.summoned:
					var to_entity = ability_relay.get_global_mouse_position().distance_to(entity.global_position)
					if to_entity < to_target:
						target = entity
						to_target = to_entity
			if target:
				var explosion_instance = target.ability_relay.make_projectile(explosion_scene, 
				target.global_position, ## position
				{"subscription" = 2, "dark_harvest" = target.ability_relay.get_health()["max_health"]}, ## inheritance
				Vector2()) ## velocity
				explosion_instance.scale_multiplier = 2
				get_node("/root/Main/Projectiles").add_child(explosion_instance)
				get_node("/root/Main").play_sound("Explosion")
				target.kill()

func damage_dealt_modifiers(_entity, damage) -> void:
	damage["multiplier"] *= 2

func attack_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0.6 + 0.4 * level

func damage_dealt(entity, damage, ability_relay) -> void:
	if bad_crop:
		status.apply(entity.ability_relay, {"stacks" = 0.05 * applicants[ability_relay]["dark_harvest"]})
		status.damage_taken(damage, entity.ability_relay)
