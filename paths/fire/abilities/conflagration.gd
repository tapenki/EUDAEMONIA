extends Ability

var burn: Node
var shock: Node
var doom: Node

var inferno: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 5:
		return
	super(ability_relay, applicant_data)

func _ready() -> void:
	burn = ability_handler.learn("burn", 0)
	shock = ability_handler.learn("shock", 0)
	doom = ability_handler.learn("doom", 0)
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	for ability_relay in applicants:
		if burn.applicants.has(dying_entity.ability_relay) or shock.applicants.has(dying_entity.ability_relay) or doom.applicants.has(dying_entity.ability_relay):
			var targets = 0
			var max_targets = 1
			if inferno:
				max_targets = 2
			for entity in ability_relay.area_targets(dying_entity.global_position, 9999):
				if entity != ability_relay.owner and entity != dying_entity and not entity.untargetable:
					if burn.applicants.has(dying_entity.ability_relay):
						burn.apply(entity.ability_relay, {"stacks" = min(10 * level, burn.applicants[dying_entity.ability_relay]["stacks"]), "duration" = ability_relay.get_effect_duration()})
					if shock.applicants.has(dying_entity.ability_relay):
						shock.apply(entity.ability_relay, {"stacks" = min(10 * level, shock.applicants[dying_entity.ability_relay]["stacks"]), "duration" = 4*ability_relay.get_effect_duration()})
					if doom.applicants.has(dying_entity.ability_relay):
						doom.apply(entity.ability_relay, {"stacks" = min(10 * level, doom.applicants[dying_entity.ability_relay]["stacks"]), "duration" = 4*ability_relay.get_effect_duration()})
					get_node("/root/Main/ParticleHandler").particle_beam("common", 
					preload("res://paths/fire/flame.png"),
					dying_entity.global_position,
					entity.global_position,
					1.0,
					32,
					Config.get_team_color(ability_relay.owner.group, "secondary"))
					targets += 1
					if targets >= max_targets:
						break
