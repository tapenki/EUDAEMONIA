extends Sprite2D

func _ready() -> void:
	rotation = owner.velocity.angle()

func _physics_process(_delta) -> void:
	rotation = owner.velocity.angle()
