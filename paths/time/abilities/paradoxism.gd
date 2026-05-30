extends Ability

var status: Node

func apply(ability_relay, applicant_data):
	if not applicant_data.has("echo_step"):
		return
	ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)

func _ready() -> void:
	status = ability_handler.learn("doom", 0)

func damage_taken(damage, ability_relay) -> void:
	var attack_scale = ability_relay.get_effect_scale()
	var reach = 150 * attack_scale
	for entity in ability_relay.area_targets(ability_relay.global_position, reach):
		status.apply(entity.ability_relay, {"stacks" = 0.1 * damage["final"], "duration" = 4*ability_relay.get_effect_duration()})
		get_node("/root/Main/ParticleHandler").particle_beam("common", 
		preload("res://paths/statuses/doom/doom.png"),
		ability_relay.global_position,
		entity.global_position,
		1.0,
		32,
		Config.get_team_color(ability_relay.owner.group, "secondary"))
