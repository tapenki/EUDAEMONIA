extends Ability

func _ready() -> void:
	var bone_shield = ability_handler.get_node_or_null("bone_shield")
	if bone_shield:
		bone_shield.osteophalanx = true

func inherit(_handler, _tier):
	return
