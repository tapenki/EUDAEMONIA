class_name Entity extends CharacterBody2D

@export var ability_handler: Node2D

@export var hurt_sound = "HurtLight"
@export var death_sound = "DeathLight"
@export var hurtbox: Hurtbox
@export var animation_player: AnimationPlayer
@export_category("stats")
@export var max_health: int = 100
@export var health: float = 100

var immune_timer = ScaledTimer.new()
@export var immune_duration: float = 0
#var knockback_timer = ScaledTimer.new()
#@export var knockback_affect: float = 1.0
@export_category("tags")
@export var group: int
@export var summoned: bool
@export var unchaseable: bool
var target

var alive = true
var still = true

func _ready() -> void:
	immune_timer.ability_handler = ability_handler
	add_child(immune_timer)
	#knockback_timer.ability_handler = ability_handler
	#add_child(knockback_timer)

func kill(modifiers = {}):
	if alive:
		ability_handler.before_self_death.emit(modifiers)
		if not modifiers.has("prevented") and (not modifiers.has("soft_prevented") or not modifiers.has("final")):
			ability_handler.death_effects.emit()
			get_node("/root/Main").entity_death.emit(self)
			ability_handler.self_death.emit()
			alive = false
			animation_player.speed_scale = 1 
			animation_player.play("DEATH")
			for ability in ability_handler.get_children():
				ability.kill()
			if hurtbox:
				#hurtbox.hit_enabled = false
				hurtbox.queue_free()
			get_node("/root/Main").play_sound(death_sound)
			get_node("/root/Main").check_finished(self)

func immune(duration: float):
	if immune_timer.time_left < duration:
		immune_timer.start(duration)

func take_damage(damage, immune_affected = true):
	if immune_affected:
		if immune_timer.running:
			return false
		else:
			immune(ability_handler.get_immune_duration({"base" : immune_duration, "multiplier" : 1}))
	
	get_node("/root/Main").play_sound(hurt_sound)
	health = health - damage["final"]
	ability_handler.damage_taken.emit(damage)
	if ability_handler.get_health()["health"] <= 0:
		kill.call_deferred(damage) ## delay to apply all effects before proceeding to kill
	return true

func heal(amount):
	var modifiers = {"base" : amount, "multiplier": 1.0}
	ability_handler.heal_modifiers.emit(modifiers)
	amount = modifiers["base"] * modifiers["multiplier"]
	health = min(max_health, health + amount)
	ability_handler.healed.emit(amount)

func _physics_process(delta):
	if not alive:
		return
	animation_player.speed_scale = ability_handler.speed_scale
	movement(delta)

func movement(_delta):
	#if knockback_timer.running:
		#if is_on_wall():
			#velocity = velocity.bounce(get_last_slide_collision().get_normal()) * 0.5
			#knockback_timer.start(knockback_timer.time_left * 0.5)
	#else:
	if still:
		velocity = lerp(velocity, Vector2(), 0.2)
	else:
		still = true
	var old_position = global_position
	var old_velocity = velocity
	velocity *= ability_handler.speed_scale
	move_and_slide()
	velocity = old_velocity
	ability_handler.movement.emit(old_position.distance_to(global_position))

func animation_finished(anim_name: StringName) -> void:
	if anim_name == "DEATH":
		queue_free()

func get_sprites():
	var sprite = get_node("Sprite")
	var size
	if sprite is EntitySprite:
		size = sprite.base_texture.get_size()
	else:
		size = sprite.texture.get_size()
	return [{"node" : sprite, "size" : size, "position" : sprite.position, "offset" : sprite.offset}]

func apply_palette(team, denominator):
	var sprites = get_sprites()
	var team_color = Config.get_team_color(team, denominator)
	for sprite in sprites:
		sprite["node"].self_modulate = team_color
		for spritechild in sprite["node"].get_children():
			if spritechild is CanvasItem:
				spritechild.self_modulate = team_color
