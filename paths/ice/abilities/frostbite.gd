extends Ability

var status: Node

var tracked: Dictionary

func _ready() -> void:
	status = ability_handler.learn("chill", 0)

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	ability_relay.damage_dealt.connect(damage_dealt.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt.is_connected(damage_dealt):
		ability_relay.damage_dealt.disconnect(damage_dealt)

func damage_dealt(entity, damage, ability_relay) -> void:
	var maxhp = entity.ability_relay.get_health()["max_health"]
	if not tracked.has(entity.ability_relay):
		entity.ability_relay.freed.connect(detrack.bind(entity.ability_relay))
		tracked[entity.ability_relay] = {"accumulated" = 0}
	tracked[entity.ability_relay]["accumulated"] += ability_relay.accumulate_damage(damage)/(maxhp/100.0)
	if tracked[entity.ability_relay]["accumulated"] >= 30:
		var count = floor(tracked[entity.ability_relay]["accumulated"] / 30)
		tracked[entity.ability_relay]["accumulated"] -= 30 * count
		status.apply(entity.ability_relay, {"duration" = level * count})

func detrack(ability_relay):
	tracked.erase(ability_relay)
	if ability_relay.freed.is_connected(detrack):
		ability_relay.freed.disconnect(detrack)
