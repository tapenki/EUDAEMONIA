extends Ability

var active = false

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 5:
		return
	ability_relay.movement.connect(movement.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if active:
		active = false
		Engine.time_scale *= 5.0

func unlearn():
	toggle_active(false)
	super()

func _ready() -> void:
	get_node("/root/Main/UI").game_menu_toggle.connect(func(_toggle):
		toggle_active(false)
	)

func toggle_active(toggle: bool):
	if toggle and not active:
		active = true
		Engine.time_scale *= 0.2
	if not toggle and active:
		active = false
		Engine.time_scale *= 5.0

func movement(_distance, ability_relay) -> void:
	if ability_relay.owner.still:
		toggle_active(true)
	else:
		toggle_active(false)
