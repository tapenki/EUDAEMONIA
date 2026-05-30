extends UIScaler

@onready var damage_bar = $DamageBar
@onready var damage_timer = $DamageTimer
@onready var health_label = $Label

@onready var player = get_node("/root/Main/UI").player
@onready var ability_relay = player.ability_relay

var button_red = preload("res://ui/button_red.png")
var button_blue = preload("res://ui/button_blue.png")

func _ready() -> void:
	super()
	ability_relay.damage_taken.connect(damage_taken)
	#ability_relay.healed.connect(healed)
	#get_node("/root/Main/PlayerAbilityHandler").abilities_changed.connect(update_hp)
	#update_hp.call_deferred()

func _process(_delta: float) -> void:
	if not get_node("/root/Main").game_over:
		var health_values = ability_relay.get_health(player.health, player.max_health)
		self.max_value = health_values["max_health"]
		self.value = health_values["health"]
		damage_bar.max_value = health_values["max_health"]
		damage_bar.value = health_values["health"]
		health_label.text = "%s/%s" % [int(ceil(health_values["health"])), int(ceil(health_values["max_health"]))]
		if self.max_value <= 0:
			self.texture_progress = button_blue
		else:
			self.texture_progress = button_red

func damage_taken(_damage) -> void:
	var health_values = ability_relay.get_health(player.health, player.max_health)
	self.max_value = health_values["max_health"]
	self.value = health_values["health"]
	damage_bar.max_value = health_values["max_health"]
	damage_bar.value = health_values["health"]
	health_label.text = "%s/%s" % [int(ceil(health_values["health"])), int(ceil(health_values["max_health"]))]
	if self.max_value <= 0:
		self.texture_progress = button_blue
	else:
		self.texture_progress = button_red
	damage_timer.start()

func _physics_process(delta: float) -> void:
	if damage_timer.is_stopped():
		damage_bar.value = max(damage_bar.value-120*delta, self.value)
