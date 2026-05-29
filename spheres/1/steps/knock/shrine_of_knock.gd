extends Described

var active = false

func _ready() -> void:
	if get_node("/root/Main/PlayerAbilityHandler").has_node("knock"):
		visible = false
	else:
		get_node("/root/Main").day_cleared.connect(activate.unbind(1))

func activate():
	get_node("../Appearance").emitting = true
	get_node("../Particles").emitting = true
	active = true
	self.texture_normal = preload("res://spheres/environment/rewards/blue_reward.png")
	get_node("Symbol").text = "Kn"

func _on_pressed() -> void:
	if not active or get_node("/root/Main").game_over or ui.upgrade_points < 1:
		get_node("/root/Main").play_sound("Error")
		return
	visible = false
	ui.upgrade_points -= 1
	get_node("/root/Main/UI/GameMenu/UpgradePoints").update_points()
	get_node("/root/Main/PlayerAbilityHandler").learn("knock", 3)
	get_node("/root/Main").play_sound("Click")
	get_node("../Particles").emitting = false
	#await get_tree().create_timer(1).timeout
	#get_parent().queue_free()

func _on_mouse_entered() -> void:
	if not active:
		return
	super()
