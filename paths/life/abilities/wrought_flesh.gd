#extends Ability
#
#func _ready() -> void:
	#if !ability_relay.is_entity:
		#process_mode = ProcessMode.PROCESS_MODE_DISABLED
	#else:
		#ability_relay.max_health_modifiers.connect(max_health_modifiers)
#
#func _physics_process(delta: float) -> void:
	#ability_relay.owner.heal(delta*level*ability_relay.speed_scale)
#
#func max_health_modifiers(modifiers) -> void:
	#modifiers["base"] += 25 * level
#
#func inherit(handler, tier):
	#if tier < 3:
		#return
	#super(handler, tier)
