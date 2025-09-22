extends Ability

var inheritance_level = 3
var type = "Upgrade"

func _ready() -> void:
	ability_handler.upgraded.connect(upgraded)
	if ability_handler.type != "Entity":
		process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _physics_process(delta: float) -> void:
	ability_handler.owner.heal(delta*level*ability_handler.speed_scale)

func upgraded(ability) -> void:
	if ability == self:
		ability_handler.owner.max_health += 25
		ability_handler.owner.health += 25
		ability_handler.update_health.emit()
