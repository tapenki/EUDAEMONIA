extends Ability

func _ready() -> void:
	ability_handler.damage_taken.connect(damage_taken)

func damage_taken(damage) -> void:
	if not damage.has("entity_source") or damage["entity_source"].group != ability_handler.owner.group:
		ability_handler.owner.health = min(ability_handler.owner.health+1, ability_handler.owner.max_health)
		ability_handler.upgrade("dark_price", 1)

func inherit(_handler, _tier):
	return
