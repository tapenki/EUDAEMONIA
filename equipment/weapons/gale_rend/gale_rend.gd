#extends Ability
#
#var bullet = preload("res://equipment/weapons/gale_rend/wind_bullet.tscn")
#const bullet_count = 4
#const spread = 60
#const wait_time = 0.7
#const bullet_speed = 750
#var time_left = 0
#
#func _ready() -> void:
#	ability_relay.attack.connect(attack)
#
#func _process(delta: float) -> void:
#	if time_left > 0:
#		time_left -= delta * ability_relay.speed_scale
#
#func attack(direction):
#	if time_left <= 0:
#		fire(direction)
#		time_left = wait_time
#
#func fire(direction):
#	var halfspan = deg_to_rad(spread) * 0.5
#	for i in bullet_count:
#		var liferangemult = randf_range(0.7, 1)
#		var bullet_instance = ability_relay.make_projectile(bullet, 
#		global_position + direction * 25, 
#		2,
#		direction.rotated(randf_range(-halfspan, halfspan)) * bullet_speed * liferangemult)
#		bullet_instance.ability_relay.inherited_damage["multiplier"] *= 0.5
#		bullet_instance.get_node("Lifetime").wait_time *= liferangemult
#		get_node("/root/Main/Projectiles").add_child(bullet_instance)
#	
#	get_node("/root/Main").play_sound("HurtLight")
#
