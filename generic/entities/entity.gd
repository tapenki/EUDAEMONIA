class_name Entity extends CharacterBody2D

@export var ability_handler: Node2D

@export var hurt_sound = "HurtLight"
@export var death_sound = "DeathLight"
@export var hurtbox: Hurtbox
@export var animation_player: AnimationPlayer

@export var max_health: int = 100
@export var health: float = 100

var immune_timer = ScaledTimer.new()
@export var immune_duration: float = 0

@export var group: int
@export var summoned: bool
var target

var alive = true

func _ready() -> void:
	immune_timer.ability_handler = ability_handler
	immune_timer.wait_time = 0
	add_child(immune_timer)

func kill():
	if alive:
		alive = false
		animation_player.play("DEATH")
		for ability in ability_handler.get_children():
			ability.kill()
		if hurtbox:
			#hurtbox.hit_enabled = false
			hurtbox.queue_free()
		get_node("/root/Main").entity_death.emit(self)
		get_node("/root/Main").play_sound(death_sound)

func immune(duration: float):
	if immune_timer.time_left < duration:
		immune_timer.start(duration)

func take_damage(source, damage, immune_affected = true):
	if immune_affected:
		if immune_timer.running:
			return
		else:
			immune(ability_handler.get_immune_duration({"source" : immune_duration, "multiplier" : 1}))
	
	get_node("/root/Main").play_sound(hurt_sound)
	var modified_damage = {"source" : damage, "multiplier" : 1}
	ability_handler.damage_taken_modifiers.emit(modified_damage)
	var final_damage = max(1, modified_damage["source"] * modified_damage["multiplier"])
	health = health - final_damage
	ability_handler.damage_taken.emit(source, final_damage)
	if ability_handler.get_health(health, max_health)["health"] <= 0:
		var death_modifiers = {"prevented" : false}
		ability_handler.before_self_death.emit(death_modifiers)
		if not death_modifiers["prevented"]:
			ability_handler.self_death.emit()
			kill.call_deferred()

func heal(amount):
	health = min(max_health, health + amount)
	ability_handler.healed.emit(amount)

func _physics_process(delta):
	if not alive:
		return
	animation_player.speed_scale = ability_handler.speed_scale
	movement(delta)

func movement(_delta):
	var old_position = global_position
	move_and_slide()
	ability_handler.movement.emit(old_position.distance_to(global_position))

func animation_finished(anim_name: StringName) -> void:
	if anim_name == "DEATH":
		queue_free()
