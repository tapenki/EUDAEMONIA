extends Ability

var status: Node

func _ready() -> void:
	status = ability_handler.learn("freeze", 0)

func apply(ability_relay, applicant_data):
	if ability_relay.owner.scene_file_path != "res://paths/ice/cryobomb/cryobomb.tscn" and not applicants.has(ability_relay.source):
		return
	super(ability_relay, applicant_data)
	ability_relay.damage_dealt.connect(damage_dealt)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt.is_connected(damage_dealt):
		ability_relay.damage_dealt.disconnect(damage_dealt)

func damage_dealt(entity, _damage) -> void:
	status.apply(entity.ability_relay, {"duration" = 1.5})
