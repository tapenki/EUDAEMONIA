extends Ability

var base_texture = preload("res://equipment/armor/cursemail/cursemail.png")
var hurt_texture = preload("res://equipment/armor/cursemail/cursemail_hurt.png")

func _ready() -> void:
	ability_handler.damage_taken_modifiers.connect(damage_taken_modifiers)
	ability_handler.damage_taken.connect(damage_taken)
	if ability_handler.owner is Player:
		ability_handler.owner.get_node("Sprite").texture = base_texture
		ability_handler.owner.get_node("Sprite").base_texture = base_texture
		ability_handler.owner.get_node("Sprite").hurt_texture = hurt_texture

func damage_taken_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0.5

func damage_taken(_source, _damage) -> void:
	ability_handler.owner.health = min(ability_handler.owner.health+1, ability_handler.owner.max_health)
	ability_handler.upgrade("dark_price", 1)

func inherit(_handler, _tier):
	return
