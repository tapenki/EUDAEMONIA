extends Projectile

var bullet = preload("res://paths/life/spike.tscn")

func _ready() -> void:
	ability_handler.death_effects.connect(death_effects)
	super()

func death_effects() -> void:
	var bullet_count = 3
	for repeat in bullet_count:
		var projectile_instance = ability_handler.make_projectile(bullet, 
		global_position + Vector2.from_angle(TAU / bullet_count * repeat) * 25,
		2,
		Vector2())
		get_node("/root/Main/Projectiles").add_child(projectile_instance)

func get_sprites():
	var sprite = get_node("Sprite")
	return [{"node" : sprite, "size" : sprite.texture.get_size(), "position" : sprite.position, "offset" : Vector2()}]
