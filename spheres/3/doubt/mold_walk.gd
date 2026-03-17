extends State

@onready var timer = $"Timer"

@export var anim: String

var direction = 1

var walking_from: Vector2
var walk_target: Vector2

@export var min_cycles = 4
@export var max_cycles = 6
var total_cycles: int
var cycle: int

@export var next: State

func _physics_process(_delta):
	if timer.running:
		user.global_position = lerp(walk_target, walking_from, timer.time_left/timer.wait_time)

func walk(): ## im bad at math so i just sorta guessed how to make it work
	if anim != "":
		if user.animation_player.current_animation == anim:
			user.animation_player.stop()
		user.animation_player.play(anim)
	
	var tiles = [Vector2i(1, 1), Vector2i(1, -1), Vector2i(-1, 1), Vector2i(-1, -1)]
	
	var tilemap = get_node("/root/Main").room_node.get_node("TileMap")
	var movement_x = 0
	var movement_y = 0
	var wallcount = 0
	for i in tiles:
		var tileposition = Vector2i(
			(user.global_position.x + tilemap.tile_set.tile_size.x * 0.5 * i.x) / tilemap.tile_set.tile_size.x,
			(user.global_position.y + tilemap.tile_set.tile_size.y * 0.5 * i.y) / tilemap.tile_set.tile_size.y
		)
		if tilemap.get_cell_source_id(tileposition) == 0:
			wallcount += 1
			movement_x += i.x
			movement_y += i.y
	
	if wallcount == 1:
		var temp_x = movement_x
		if direction == 1:
			movement_x += movement_y 
			movement_y -= temp_x
		else:
			movement_x -= movement_y 
			movement_y += temp_x
	elif wallcount == 2:
		var temp_x = movement_x
		movement_x = movement_y * direction
		movement_y = -temp_x * direction
	elif wallcount == 3:
		var temp_x = movement_x
		if direction == 1:
			movement_x -= movement_y 
			movement_y += temp_x
		else:
			movement_x += movement_y 
			movement_y -= temp_x
		movement_x *= -1
		movement_y *= -1
	
	movement_x = clamp(movement_x, -1, 1)
	movement_y = clamp(movement_y, -1, 1)
	
	walking_from = user.global_position
	walk_target = user.global_position + Vector2(movement_x * tilemap.tile_set.tile_size.x, movement_y * tilemap.tile_set.tile_size.y)
	timer.start()

func on_enter() -> void:
	super()
	
	if randi() % 2 == 0:
		direction = 1
	else:
		direction = -1
	
	total_cycles = randi_range(min_cycles, max_cycles)
	cycle = 1
	walk()

func _on_timer_timeout() -> void:
	if cycle < total_cycles:
		cycle += 1
		walk()
	else:
		state_handler.change_state(next)
