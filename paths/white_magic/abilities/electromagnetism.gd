extends Ability

var inheritance_level = 1

var velocity_decay = false

func _ready() -> void:
	if ability_handler.type != "projectile":
		process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _physics_process(_delta: float) -> void:
	var attack_scale = ability_handler.get_attack_scale({"source" : 0, "multiplier" : 0.5 + 0.5 * level, "flat" : 0})
	var target = ability_handler.find_target(ability_handler.owner.global_position, 100 * attack_scale, ability_handler.owner.exclude)
	if target:
		var target_direction = ability_handler.owner.global_position.direction_to(target.global_position)
		ability_handler.owner.velocity += target_direction * 60
		if not velocity_decay:
			velocity_decay = true
	if velocity_decay:
		ability_handler.owner.velocity = ability_handler.owner.velocity.limit_length(pow(ability_handler.owner.velocity.length(), 0.99))
