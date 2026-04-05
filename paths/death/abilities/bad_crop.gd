#extends Ability
#
#func _ready() -> void:
	#if ability_relay.owner is Player:
		#return
	#ability_relay.damage_dealt.connect(damage_dealt)
	#
#func damage_dealt(entity, damage) -> void:
	#var has_doom = entity.ability_relay.has_node("doom")
	#var doom = ability_relay.apply_status(entity.ability_relay, "doom", 6)
	#if not has_doom:
		#doom.stored_damage += damage["final"]
#
#func inherit(handler, tier):
	#if handler.owner.scene_file_path != "res://paths/death/harvest_explosion.tscn" and ability_relay.owner.scene_file_path != "res://paths/death/harvest_explosion.tscn":
		#return
	#super(handler, tier)
