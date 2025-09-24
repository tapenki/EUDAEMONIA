extends Ability

var inheritance_level = 3
var type = "Upgrade"

#var burn_script = preload("res://generic/abilities/status/burn.gd")
var explosion_scene = preload("res://generic/particles/explosion.tscn")
var recovery_timer = ScaledTimer.new()

var active = true

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
		ability_handler.owner.immune(ability_handler.owner.immune_duration * 5)
		get_node("/root/Main").spawn_particles(explosion_scene, global_position, 2, Config.get_team_color(ability_handler.owner.group, "secondary"))

func day_start(_day: int) -> void:
	active = true
