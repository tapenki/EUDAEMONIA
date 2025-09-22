extends Ability

var inheritance_level = 4
var type = "Special"

var explosion_scene = preload("res://generic/projectiles/explosion.tscn")

var explosion_timer = ScaledTimer.new()

var stored_damage: float

func _ready() -> void:
	explosion_timer.ability_handler = ability_handler
	add_child(explosion_timer)
	explosion_timer.timeout.connect(timeout)
	ability_handler.damage_taken.connect(damage_taken)
	ability_handler.before_self_death.connect(before_self_death)

func damage_taken(_source, damage) -> void:
	stored_damage += damage
	if not explosion_timer.running and ability_handler.owner.alive:
		explosion_timer.start(3)
		ability_handler.owner.get_node("AnimationPlayer").play("PRIMED")

func before_self_death(modifiers) -> void:
	ability_handler.owner.health = 1
	modifiers["prevented"] = true

func timeout() -> void:
	var explosion_instance = ability_handler.make_projectile(explosion_scene, 
	global_position, ## position
	3, ## inheritance
	Vector2(), ## velocity
	{"source" : stored_damage, "multiplier" : 1}, ## damage
	{"source" : 0, "multiplier" : 1}, ## scale
	ability_handler.get_enemy_group()) 
	explosion_instance.scale_multiplier = 8
	get_node("/root/Main/Projectiles").add_child(explosion_instance)
	
	var damage =  {"source" : stored_damage, "multiplier" : 0.25*level}
	explosion_instance.ability_handler.inherited_damage = damage
	ability_handler.owner.kill()
