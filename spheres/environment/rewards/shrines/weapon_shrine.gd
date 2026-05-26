extends Shrine

@onready var ui = get_node("/root/Main/UI")

var active = false

func _ready() -> void:
	get_node("/root/Main").day_cleared.connect(activate.unbind(1))

func activate():
	get_node("Appearance").emitting = true
	get_node("Particles").emitting = true
	active = true
	get_node("Button/TextureRect1").texture = preload("res://affects/ui/weapon.png")
	get_node("Button/TextureRect2").texture = preload("res://spheres/environment/rewards/green_reward.png")
	get_node("Button/Symbol").text = subject.substr(0, 2).capitalize()

func _on_pressed() -> void:
	if not active or get_node("/root/Main").game_over or ui.upgrade_points < 1:
		get_node("/root/Main").play_sound("Error")
		return
	visible = false
	ui.upgrade_points -= 1
	get_node("/root/Main/UI/GameMenu/UpgradePoints").update_points()
	get_node("/root/Main/PlayerAbilityHandler").learn(subject, 1)
	get_node("/root/Main/PlayerAbilityHandler").equip_weapon(subject)
	get_node("/root/Main").play_sound("Click")
	get_node("Particles").emitting = false
	#await get_tree().create_timer(1).timeout
	#get_parent().queue_free()

func _on_mouse_entered() -> void:
	if not active:
		return
	super()
