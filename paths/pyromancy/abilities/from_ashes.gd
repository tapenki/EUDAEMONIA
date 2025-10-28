extends Ability

var recovery_timer = ScaledTimer.new()

var active = true
var fiery_rebirth: bool

func _ready() -> void:
	recovery_timer.ability_handler = ability_handler
	add_child(recovery_timer)
	ability_handler.before_self_death.connect(before_self_death)
	get_node("/root/Main").day_start.connect(day_start)

func _physics_process(delta: float) -> void:
	if recovery_timer.running:
		ability_handler.owner.heal(delta*10*level*ability_handler.speed_scale)

func before_self_death(modifiers) -> void:
	if active and not modifiers["prevented"]:
		active = false
		modifiers["prevented"] = true
		recovery_timer.start(5)
		var health_values = ability_handler.get_health(ability_handler.owner.health, ability_handler.owner.max_health)
		ability_handler.owner.health = max(ability_handler.owner.health, ability_handler.owner.max_health - health_values["max_health"])
		ability_handler.owner.immune(ability_handler.get_immune_duration({"source" : ability_handler.owner.immune_duration, "multiplier" : 4}))
		if fiery_rebirth:
			for target in ability_handler.area_targets(global_position):
				var burn = ability_handler.apply_status(target.ability_handler, "burn", level * 10)
				if burn:
					burn.mult_level(2)
			get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/Fire"), 16, global_position, 4, Config.get_team_color(ability_handler.owner.group, "secondary"))
		else:
			get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/Fire"), 16, global_position, 2, Config.get_team_color(ability_handler.owner.group, "secondary"))

func day_start(_day: int) -> void:
	active = true

func inherit(handler, tier):
	if tier < 3:
		return
	super(handler, tier)
