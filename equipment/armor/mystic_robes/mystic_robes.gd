extends Ability

var base_texture = preload("res://equipment/armor/mystic_robes/mystic_robes.png")
var hurt_texture = preload("res://equipment/armor/mystic_robes/mystic_robes_hurt.png")

func _ready() -> void:
	if ability_handler.owner is Player:
		get_node("/root/Main/UI").unlock_points += 1
		get_node("/root/Main/UI/GameMenu/UpgradePoints").update()
		ability_handler.owner.get_node("Sprite").texture = base_texture
		ability_handler.owner.get_node("Sprite").base_texture = base_texture
		ability_handler.owner.get_node("Sprite").hurt_texture = hurt_texture

func inherit(_handler, _tier):
	return
