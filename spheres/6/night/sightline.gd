extends Sprite2D

@onready var ability_relay = get_node("%AbilityRelay")

@export var bullet = preload("res://spheres/6/night/moon_bullet/moon_bullet.tscn")
@export var bullet_lifetime = 1.0
@export var bullet_count = 7
@export var spread = 90
@export var bullet_speed = 600

@export var shoot_delay = 1.5
var cooldown = 0.0

@export var radius = 384
@export var angle = 60

func _ready() -> void:
	self_modulate = Config.get_team_color(owner.group, "secondary")
	self_modulate.a = 0.5
	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.2)
	ability_relay.self_death.connect(self_death)

func _physics_process(delta: float) -> void:
	if cooldown < shoot_delay:
		cooldown += delta
	else:
		self_modulate.a = 1
		if not owner.alive:
			return
		var enemies = ability_relay.area_targets(global_position, radius)
		for enemy in enemies:
			var angle_to_enemy = global_position.angle_to_point(enemy.global_position)
			if abs(angle_difference(global_rotation, angle_to_enemy)) < deg_to_rad(angle) * 0.5:
				cooldown = 0.0
				self_modulate.a = 0.5
				var color = self_modulate ## yea
				color.a = 1.0
				get_node("/root/Main").floating_text(global_position, "[!]", color)
				
				var direction = Vector2.from_angle(angle_to_enemy)
				var stepsize = deg_to_rad(spread) / (bullet_count - 1)
				var halfspan = deg_to_rad(spread) * 0.5
				for i in bullet_count:
					var bullet_instance = ability_relay.make_projectile(bullet, 
					global_position + direction * 25, 
					{"subscription" = 2},
					direction.rotated(halfspan - (stepsize * i)) * bullet_speed)
					bullet_instance.get_node("Lifetime").wait_time = bullet_lifetime
					get_node("/root/Main/Projectiles").add_child(bullet_instance)
				get_node("/root/Main").play_sound("ShootLight")

func self_death() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.2)
