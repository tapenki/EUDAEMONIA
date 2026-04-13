extends Ability

var status: Node

var fiery_rebirth: bool

func _ready() -> void:
	status = ability_handler.learn("burn", 0)
	get_node("/root/Main").day_start.connect(day_start)

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	applicant_data["active"] = true
	applicant_data["recovery"] = 0.0
	super(ability_relay, applicant_data)
	ability_relay.before_self_death.connect(before_self_death.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.before_self_death.is_connected(before_self_death):
		ability_relay.before_self_death.disconnect(before_self_death)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay]["recovery"] > 0:
			applicants[ability_relay]["recovery"] -= delta * ability_relay.speed_scale
			ability_relay.owner.heal(delta*12*level*ability_relay.speed_scale)

func before_self_death(modifiers, ability_relay) -> void:
	if applicants[ability_relay]["active"] and not modifiers.has("prevented"):
		applicants[ability_relay]["active"] = false
		applicants[ability_relay]["recovery"] = 4.0
		modifiers["prevented"] = true
		var health_values = ability_relay.get_health(ability_relay.owner.health, ability_relay.owner.max_health)
		ability_relay.owner.health = max(ability_relay.owner.health, ability_relay.owner.max_health - health_values["max_health"])
		ability_relay.owner.immune(ability_relay.get_immune_duration({"base" : ability_relay.owner.immune_duration, "multiplier" : 4}))
		if fiery_rebirth:
			for target in ability_relay.area_targets(ability_relay.global_position):
				status.apply(target.ability_relay, {"stacks" = level})
				if status.applicants.has(target.ability_relay):
					status.applicants[target.ability_relay]["stacks"] *= 2
			get_node("/root/Main/ParticleHandler").quick_particles("burst", 
			preload("res://paths/fire/flame.png"),
			ability_relay.global_position,
			4,
			16,
			Config.get_team_color(ability_relay.owner.group, "secondary"))
		else:
			get_node("/root/Main/ParticleHandler").quick_particles("burst", 
			preload("res://paths/fire/flame.png"),
			ability_relay.global_position,
			2,
			16,
			Config.get_team_color(ability_relay.owner.group, "secondary"))

func day_start(_day: int) -> void:
	for ability_relay in applicants:
		applicants[ability_relay]["active"] = true
