extends Ability

func _ready() -> void:
	ability_handler.damage_taken.connect(damage_taken)

func damage_taken(_source, _damage) -> void:
	ability_handler.owner.health = min(ability_handler.owner.health+1, ability_handler.owner.max_health)
	ability_handler.upgrade("dark_price", 1)

func inherit(_handler, _tier):
	return
