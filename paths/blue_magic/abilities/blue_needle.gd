extends Ability

var inheritance_level = 3
var type = "Upgrade"

func _ready() -> void:
	ability_handler.projectile_created.connect(projectile_created)

func projectile_created(projectile):
	if projectile.hits_left > 0:
		projectile.hits_left += level
