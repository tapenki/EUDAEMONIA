extends Ability

func _ready() -> void:
	ability_relay.damage_taken.connect(damage_taken)

func damage_taken(damage) -> void:
	if not damage.has("entity_source") or damage["entity_source"].group != ability_relay.owner.group:
		ability_relay.owner.health = min(ability_relay.owner.health+5, ability_relay.owner.max_health)
		ability_relay.upgrade("dark_price", 5)

func inherit(_handler, _tier):
	return
