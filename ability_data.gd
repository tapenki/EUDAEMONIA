extends Node

var path_data = {
	"fire" : {
		"scene" : preload("res://paths/fire/fire_ui.tscn"),
	},
	"ice" : {
		"scene" : preload("res://paths/ice/ice_ui.tscn"),
	},
	"lightning" : {
		"scene" : preload("res://paths/lightning/lightning_ui.tscn"),
	},
	"life" : {
		"scene" : preload("res://paths/life/life_ui.tscn"),
	},
	"death" : {
		"scene" : preload("res://paths/death/death_ui.tscn"),
	},
	"blade" : {
		"scene" : preload("res://paths/blade/blade_ui.tscn"),
	},
}

var ability_data = {
	#region weapons
	"magic_missile" : {
		"script" : preload("res://affects/equipment/weapons/magic_missile/magic_missile.gd"),
		"type" : "weapon",
		"affect" : preload("res://affects/ui/weapon_button.tscn")
	},
	#endregion
	#region challenges
	"lasting_wounds" : {
		"script" : preload("res://affects/challenges/lasting_wounds.gd"),
		"type" : "challenge",
		"affect" : preload("res://affects/challenges/ui/challenge_reminder.tscn")
	},
	"burning_hours" : {
		"script" : preload("res://affects/challenges/burning_hours.gd"),
		"type" : "challenge",
		"affect" : preload("res://affects/challenges/ui/challenge_reminder.tscn")
	},
	"era_wince" : {
		"script" : preload("res://affects/challenges/era_wince.gd"),
		"type" : "challenge",
		"affect" : preload("res://affects/challenges/ui/challenge_reminder.tscn")
	},
	"atrophy" : {
		"script" : preload("res://affects/challenges/atrophy.gd"),
		"type" : "challenge",
		"affect" : preload("res://affects/challenges/ui/challenge_reminder.tscn")
	},
	"vulnerability" : {
		"script" : preload("res://affects/challenges/vulnerability.gd"),
		"type" : "challenge",
		"affect" : preload("res://affects/challenges/ui/challenge_reminder.tscn")
	},
	#endregion
	#region statuses
	"burn" : {
		"script" : preload("res://paths/statuses/burn/burn.gd"),
		"type" : "status"
	},
	"chill" : {
		"script" : preload("res://paths/statuses/chill/chill.gd"),
		"type" : "status"
	},
	"freeze" : {
		"script" : preload("res://paths/statuses/freeze/freeze.gd"),
		"type" : "status"
	},
	"shock" : {
		"script" : preload("res://paths/statuses/shock/shock.gd"),
		"type" : "status"
	},
	"doom" : {
		"script" : preload("res://paths/statuses/doom/doom.gd"),
		"type" : "status"
	},
	#endregion
	#region fire
	"ignition" : {
		"script" : preload("res://paths/fire/abilities/ignition.gd"),
		"type" : "upgrade"
	},
	"firespawning" : {
		"script" : preload("res://paths/fire/abilities/firespawning.gd"),
		"type" : "upgrade"
	},
	"conflagration" : {
		"script" : preload("res://paths/fire/abilities/conflagration.gd"),
		"type" : "upgrade"
	},
	"scorched_earth" : {
		"script" : preload("res://paths/fire/abilities/scorched_earth.gd"),
		"type" : "upgrade"
	},
	"from_ashes" : {
		"script" : preload("res://paths/fire/abilities/from_ashes.gd"),
		"type" : "upgrade"
	},
	"pyre" : {
		"script" : preload("res://paths/fire/abilities/pyre.gd"),
		"type" : "mastery"
	},
	"undying_flames" : {
		"script" : preload("res://paths/fire/abilities/undying_flames.gd"),
		"type" : "mastery"
	},
	"inferno" : {
		"script" : preload("res://paths/fire/abilities/inferno.gd"),
		"type" : "mastery"
	},
	"ring_of_fire" : {
		"script" : preload("res://paths/fire/abilities/ring_of_fire.gd"),
		"type" : "mastery"
	},
	"fiery_rebirth" : {
		"script" : preload("res://paths/fire/abilities/fiery_rebirth.gd"),
		"type" : "mastery"
	},
	#endregion
	#region ice
	"blue_needle" : {
		"script" : preload("res://paths/ice/abilities/blue_needle.gd"),
		"type" : "upgrade"
	},
	"snowball" : {
		"script" : preload("res://paths/ice/abilities/snowball.gd"),
		"type" : "upgrade"
	},
	"shatter" : {
		"script" : preload("res://paths/ice/abilities/shatter.gd"),
		"type" : "upgrade"
	},
	"frostbite" : {
		"script" : preload("res://paths/ice/abilities/frostbite.gd"),
		"type" : "upgrade"
	},
	
	"cryobombs" : {
		"script" : preload("res://paths/ice/abilities/cryobombs.gd"),
		"type" : "upgrade"
	},
	"glacial_rail" : {
		"script" : preload("res://paths/ice/abilities/glacial_rail.gd"),
		"type" : "mastery"
	},
	"snowball_ii" : {
		"script" : preload("res://paths/ice/abilities/snowball_ii.gd"),
		"type" : "mastery"
	},
	"snap_freeze" : {
		"script" : preload("res://paths/ice/abilities/snap_freeze.gd"),
		"type" : "mastery"
	},
	"brittle_cold" : {
		"script" : preload("res://paths/ice/abilities/brittle_cold.gd"),
		"type" : "mastery"
	},
	"freeze_blast" : {
		"script" : preload("res://paths/ice/abilities/freeze_blast.gd"),
		"type" : "mastery"
	},
	#endregion
	#region lightning
	"chain_bolt" : {
		"script" : preload("res://paths/lightning/abilities/chain_bolt.gd"),
		"type" : "upgrade"
	},
	"mortal_shock" : {
		"script" : preload("res://paths/lightning/abilities/mortal_shock.gd"),
		"type" : "upgrade"
	},
	"electromagnetism" : {
		"script" : preload("res://paths/lightning/abilities/electromagnetism.gd"),
		"type" : "upgrade"
	},
	"ball_lightning" : {
		"script" : preload("res://paths/lightning/abilities/ball_lightning.gd"),
		"type" : "upgrade"
	},
	"thunderstep" : {
		"script" : preload("res://paths/lightning/abilities/thunderstep.gd"),
		"type" : "upgrade"
	},
	"storm_weave" : {
		"script" : preload("res://paths/lightning/abilities/storm_weave.gd"),
		"type" : "mastery"
	},
	"shocking_grasp" : {
		"script" : preload("res://paths/lightning/abilities/shocking_grasp.gd"),
		"type" : "mastery"
	},
	"covalence" : {
		"script" : preload("res://paths/lightning/abilities/covalence.gd"),
		"type" : "mastery"
	},
	"repulsar" : {
		"script" : preload("res://paths/lightning/abilities/repulsar.gd"),
		"type" : "mastery"
	},
	"arc_shield" : {
		"script" : preload("res://paths/lightning/abilities/arc_shield.gd"),
		"type" : "mastery"
	},
	#endregion
	#region life
	"enrage" : {
		"script" : preload("res://paths/life/abilities/enrage.gd"),
		"type" : "upgrade"
	},
	"trail_of_thorns" : {
		"script" : preload("res://paths/life/abilities/trail_of_thorns.gd"),
		"type" : "upgrade"
	},
	"quill_spray" : {
		"script" : preload("res://paths/life/abilities/quill_spray.gd"),
		"type" : "upgrade"
	},
	"wrought_flesh" : {
		"script" : preload("res://paths/life/abilities/wrought_flesh.gd"),
		"type" : "upgrade"
	},
	"animated_clay" : {
		"script" : preload("res://paths/life/abilities/animated_clay.gd"),
		"type" : "upgrade"
	},
	"bramble_shot" : {
		"script" : preload("res://paths/life/abilities/bramble_shot.gd"),
		"type" : "mastery"
	},
	"pain_walk" : {
		"script" : preload("res://paths/life/abilities/pain_walk.gd"),
		"type" : "mastery"
	},
	"vitalism" : {
		"script" : preload("res://paths/life/abilities/vitalism.gd"),
		"type" : "mastery"
	},
	"pressurized_quills" : {
		"script" : preload("res://paths/life/abilities/pressurized_quills.gd"),
		"type" : "mastery"
	},
	"multimold" : {
		"script" : preload("res://paths/life/abilities/multimold.gd"),
		"type" : "mastery"
	},
	#endregion
	#region death
	"army_of_the_dead" : {
		"script" : preload("res://paths/death/abilities/army_of_the_dead.gd"),
		"type" : "upgrade"
	},
	"fated_end" : {
		"script" : preload("res://paths/death/abilities/fated_end.gd"),
		"type" : "upgrade"
	},
	"hunger" : {
		"script" : preload("res://paths/death/abilities/hunger.gd"),
		"type" : "upgrade"
	},
	"bone_shield" : {
		"script" : preload("res://paths/death/abilities/bone_shield.gd"),
		"type" : "upgrade"
	},
	"dark_harvest" : {
		"script" : preload("res://paths/death/abilities/dark_harvest.gd"),
		"type" : "upgrade"
	},
	"soul_tether" : {
		"script" : preload("res://paths/death/abilities/soul_tether.gd"),
		"type" : "mastery"
	},
	"swift_fate" : {
		"script" : preload("res://paths/death/abilities/swift_fate.gd"),
		"type" : "mastery"
	},
	"starvation" : {
		"script" : preload("res://paths/death/abilities/starvation.gd"),
		"type" : "mastery"
	},
	"osteophalanx" : {
		"script" : preload("res://paths/death/abilities/osteophalanx.gd"),
		"type" : "mastery"
	},
	"bad_crop" : {
		"script" : preload("res://paths/death/abilities/bad_crop.gd"),
		"type" : "mastery"
	},
	#endregion
	#region blade
	"hold_ground" : {
		"script" : preload("res://paths/blade/abilities/hold_ground.gd"),
		"type" : "upgrade"
	},
	"broad_swings" : {
		"script" : preload("res://paths/blade/abilities/broad_swings.gd"),
		"type" : "upgrade"
	},
	"block" : {
		"script" : preload("res://paths/blade/abilities/block.gd"),
		"type" : "upgrade"
	},
	"deflect" : {
		"script" : preload("res://paths/blade/abilities/deflect.gd"),
		"type" : "upgrade"
	},
	"unsheathe" : {
		"script" : preload("res://paths/blade/abilities/unsheathe.gd"),
		"type" : "upgrade"
	},
	"unflinching" : {
		"script" : preload("res://paths/blade/abilities/unflinching.gd"),
		"type" : "mastery"
	},
	"percussion" : {
		"script" : preload("res://paths/blade/abilities/percussion.gd"),
		"type" : "mastery"
	},
	"sword" : {
		"script" : preload("res://paths/blade/sword/sword.gd"),
		"type" : "weapon"
	},
	#endregion
	#region misc
	"health_boost" : {
		"script" : preload("res://affects/health_boost.gd"),
		"type" : "token",
		"affect" : preload("res://affects/ui/health_boost_reminder.tscn")
	},
	"damage_boost" : {
		"script" : preload("res://affects/damage_boost.gd"),
		"type" : "token",
		"affect" : preload("res://affects/ui/damage_boost_reminder.tscn")
	},
	"dark_price" : {
		"script" : preload("res://affects/dark_price.gd"),
		"type" : "token",
		"affect" : preload("res://affects/ui/dark_price_reminder.tscn")
	}
	#endregion
}
