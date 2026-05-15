extends Described

var auto_collect_timer = 0.0
var auto_collect_timer_running = false
var free_timer = 0.0
var free_timer_running = false

func _ready() -> void:
	get_node("../Appearance").emitting = true
	if Config.config.get_value("gameplay", "auto_collect"):
		auto_collect_timer_running = true

func _process(delta: float) -> void:
	if auto_collect_timer_running:
		auto_collect_timer += delta
		if auto_collect_timer >= 1.0:
			_on_pressed()
	if free_timer_running:
		free_timer += delta
		if free_timer >= 1.0:
			get_parent().queue_free()

func _on_pressed() -> void:
	auto_collect_timer_running = false
	if get_node("/root/Main").game_over:
		get_node("/root/Main").play_sound("Error")
		return
	visible = false
	var player = get_node("/root/Main/UI").player
	player.ability_relay.upgrade("health_boost", 40)
	player.recover()
	get_node("/root/Main").play_sound("Click")
	get_node("../Particles").emitting = false
	free_timer_running = true
