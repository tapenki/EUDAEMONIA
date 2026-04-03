extends Sprite2D

@export var ability_relay: Node
@export var bullet: PackedScene

func _physics_process(_delta: float) -> void:
	scale = Vector2(0.8, 0.8) * (1 - sin(Time.get_ticks_msec()*0.005) * 0.1)

func _ready() -> void:
	ability_relay.damage_taken.connect(damage_taken)

func damage_taken(_damage) -> void:
	if visible:
		visible = false
		var angle = randf_range(0, TAU)
		const count = 3
		for repeat in count:
			var bullet_instance = ability_relay.make_projectile(bullet, 
			global_position, 
			2,
			Vector2.from_angle(angle + (TAU / count * repeat)) * 300)
			bullet_instance.get_node("Lifetime").start(0.75)
			get_node("/root/Main/Projectiles").add_child(bullet_instance)
		get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/Impact"), 5, global_position, 3, Config.get_team_color(ability_relay.owner.group, "secondary"))
