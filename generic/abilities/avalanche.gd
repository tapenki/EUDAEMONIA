#extends Ability
#
#var inheritance_level = 3
#var type = "Upgrade"
#
#var bullet = preload("res://generic/projectiles/sky_bullet.tscn")
#var charge_timer = Timer.new()
#
#func _ready() -> void:
	#charge_timer.wait_time = 0.5
	#charge_timer.timeout.connect(tick)
	#add_child(charge_timer)
	#charge_timer.start()
	#get_node("/root/Main").day_start.connect(day_start)
	#
#func day_start(_day: int) -> void:
	#charge_timer.start()
#
#func tick():
	#var rain_position = Vector2(randf_range(100, 800), randf_range(100, 500))
	#var target = ability_handler.find_target(rain_position, 400)
	#if target:
	#	rain_position = target.global_position
	#var bullet_instance = ability_handler.make_projectile(bullet, 
	#rain_position, 
	#3,
	#Vector2(),
	#{"base" : 0, "multiplier" : level})
	#get_node("/root/Main/Projectiles").add_child(bullet_instance)
