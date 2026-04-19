extends Ability

var status: Node

func get_block_level():
	var block = ability_handler.get_node_or_null("block")
	if block:
		return block.level
	return 1

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)

func _ready() -> void:
	status = ability_handler.learn("shock", 0)

func damage_taken(damage, ability_relay) -> void:
	if damage.has("blocked"):
		var attack_scale = ability_relay.get_attack_scale({"base" : 0, "multiplier" : 1})
		var reach = 150 * attack_scale
		for entity in ability_relay.area_targets(ability_relay.global_position, reach):
			status.apply(entity.ability_relay, {"stacks" = 5 * get_block_level()})
			get_node("/root/Main/ParticleHandler").particle_beam("common", 
			preload("res://paths/statuses/shock/shock.png"),
			ability_relay.global_position,
			entity.global_position,
			1.0,
			32,
			Config.get_team_color(ability_relay.owner.group, "secondary"))
