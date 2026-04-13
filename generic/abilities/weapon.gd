class_name Weapon extends Ability

var equipped: bool

func _ready() -> void:
	ability_handler.weapons_changed.connect(weapons_changed)
	weapons_changed()

func weapons_changed():
	equipped = ability_handler.equipped_weapons.has(self.name)
