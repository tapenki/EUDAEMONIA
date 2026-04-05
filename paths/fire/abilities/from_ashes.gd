#extends Ability
#
#var recovery_timer = ScaledTimer.new()
#
#var active = true
#var fiery_rebirth: bool
#
#func _ready() -> void:
	#recovery_timer.ability_relay = ability_relay
	#add_child(recovery_timer)
	#ability_relay.before_self_death.connect(before_self_death)
	#get_node("/root/Main").day_start.connect(day_start)
#
#func _physics_process(delta: float) -> void:
	#if recovery_timer.running:
		#ability_relay.owner.heal(delta*10*level*ability_relay.speed_scale)
#
#func before_self_death(modifiers) -> void:
	#if active and not modifiers.has("prevented"):
		#active = false
		#modifiers["prevented"] = true
		#recovery_timer.start(5)
		#var health_values = ability_relay.get_health(ability_relay.owner.health, ability_relay.owner.max_health)
		#ability_relay.owner.health = max(ability_relay.owner.health, ability_relay.owner.max_health - health_values["max_health"])
		#ability_relay.owner.immune(ability_relay.get_immune_duration({"base" : ability_relay.owner.immune_duration, "multiplier" : 4}))
		#if fiery_rebirth:
			#for target in ability_relay.area_targets(global_position):
				#var burn = ability_relay.apply_status(target.ability_relay, "burn", level * 10)
				#if burn:
					#burn.mult_level(2)
			#get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/Fire"), 16, global_position, 4, Config.get_team_color(ability_relay.owner.group, "secondary"))
		#else:
			#get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/Fire"), 16, global_position, 2, Config.get_team_color(ability_relay.owner.group, "secondary"))
#
#func day_start(_day: int) -> void:
	#active = true
#
#func inherit(handler, tier):
	#if tier < 3:
		#return
	#super(handler, tier)
