extends Node2D

@export var projectile_scene: PackedScene

@export var comet_count = 2
@export var orbit_distance = 200
@export var orbit_speed = 1.0

func _ready() -> void:
	for repeat in comet_count:
		var projectile_instance = projectile_scene.instantiate()
		get_node("/root/Main").assign_projectile_group(projectile_instance, 2, "secondary")
		projectile_instance.position = Vector2.from_angle(TAU / comet_count * repeat) * orbit_distance
		projectile_instance.ability_relay.inherited_damage["multiplier"] = get_node("/root/Main").scale_enemy_damage()
		projectile_instance.get_node("Sprite").rotation = (Vector2.from_angle(PI * 0.5 + (TAU / comet_count * repeat)) * sign(orbit_speed)).angle()
		add_child(projectile_instance)

func _physics_process(delta: float) -> void:
	rotation += delta * PI * orbit_speed
