extends Ability

var base_texture = preload("res://equipment/armor/hermits_cloak/hermits_cloak.png")
var hurt_texture = preload("res://equipment/armor/hermits_cloak/hermits_cloak_hurt.png")

func _ready() -> void:
	if ability_handler.is_entity:
		ability_handler.max_health_modifiers.connect(max_health_modifiers)
		if ability_handler.owner is Player:
			ability_handler.owner.get_node("Sprite").texture = base_texture
			ability_handler.owner.get_node("Sprite").base_texture = base_texture
			ability_handler.owner.get_node("Sprite").hurt_texture = hurt_texture

func max_health_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 1.25

func inherit(_handler, _tier):
	return
