extends TextureProgressBar

@onready var damage_bar = $DamageBar
@onready var damage_timer = $DamageTimer
@onready var health_label = $Label

@onready var player = $"../../".player
@onready var ability_handler = player.ability_handler

func _ready() -> void:
	ability_handler.damage_taken.connect(damage_taken)
	ability_handler.healed.connect(healed)
	get_node("/root/Main/UI").update_abilities.connect(update)
	update.call_deferred()

func update() -> void:
	var health_values = ability_handler.get_health(player.health, player.max_health)
	max_value = health_values["max_health"]
	value = health_values["health"]
	damage_bar.max_value = health_values["max_health"]
	damage_bar.value = health_values["health"]
	health_label.text = "%s/%s" % [int(ceil(health_values["health"])), int(ceil(health_values["max_health"]))]

func damage_taken(_source, _damage) -> void:
	var health_values = ability_handler.get_health(player.health, player.max_health)
	value = health_values["health"]
	health_label.text = "%s/%s" % [int(ceil(health_values["health"])), int(ceil(health_values["max_health"]))]
	damage_timer.start()

func healed(_amount) -> void:
	var health_values = ability_handler.get_health(player.health, player.max_health)
	value = health_values["health"]
	health_label.text = "%s/%s" % [int(ceil(health_values["health"])), int(ceil(health_values["max_health"]))]

func _physics_process(delta: float) -> void:
	if damage_timer.is_stopped():
		damage_bar.value = max(damage_bar.value-120*delta, value)
