extends Ability

var damage_boost = 1.0
var scale_boost = 1.0

func _ready() -> void:
	ability_handler.attack_scale_modifiers.connect(attack_scale_modifiers)
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if ability_handler.type != "projectile":
		process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _physics_process(delta: float) -> void:
	damage_boost += 0.5 * delta * level * ability_handler.speed_scale
	scale_boost += (1 - pow(0.5, level)) * delta * ability_handler.speed_scale

func attack_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= scale_boost

func damage_dealt_modifiers(_entity, modifiers, _crits) -> void:
	modifiers["multiplier"] *= damage_boost

func crit_chance_modifiers(_entity, modifiers) -> void:
	modifiers["multiplier"] *= damage_boost

func status_level_modifiers(_status, modifiers) -> void:
	modifiers["multiplier"] *= damage_boost

func inherit(handler, tier):
	var ability_node = super(handler, tier)
	ability_node.damage_boost += damage_boost - 1
	ability_node.scale_boost += scale_boost - 1
