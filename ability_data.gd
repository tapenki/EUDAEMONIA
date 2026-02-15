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
}

var ability_data = {
	#region weapons
	"magic_missile" : {
		"script" : preload("res://equipment/weapons/magic_missile/magic_missile.gd"),
		"type" : "weapon"
	},
	"star_blaze" : {
		"script" : preload("res://equipment/weapons/star_blaze/star_blaze.gd"),
		"type" : "weapon"
	},
	"gale_rend" : {
		"script" : preload("res://equipment/weapons/gale_rend/gale_rend.gd"),
		"type" : "weapon"
	},
	"trick_bullets" : {
		"script" : preload("res://equipment/weapons/trick_bullets/trick_bullets.gd"),
		"type" : "weapon"
	},
	#endregion
	#region armor
	"hermits_cloak" : {
		"script" : preload("res://equipment/armor/hermits_cloak/hermits_cloak.gd"),
		"type" : "armor"
	},
	"mystic_robes" : {
		"script" : preload("res://equipment/armor/mystic_robes/mystic_robes.gd"),
		"type" : "armor"
	},
	"cursemail" : {
		"script" : preload("res://equipment/armor/cursemail/cursemail.gd"),
		"type" : "armor"
	},
	#endregion
	#region challenges
	"lasting_wounds" : {
		"script" : preload("res://challenges/lasting_wounds.gd"),
		"type" : "challenge"
	},
	"burning_hours" : {
		"script" : preload("res://challenges/burning_hours.gd"),
		"type" : "challenge"
	},
	"era_wink" : {
		"script" : preload("res://challenges/era_wink.gd"),
		"type" : "challenge"
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
	"fireburst" : {
		"script" : preload("res://paths/fire/flaming_skull/fireburst.gd"),
		"type" : "token"
	},
	"melt" : {
		"script" : preload("res://paths/fire/abilities/melt.gd"),
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
	"conflagration" : {
		"script" : preload("res://paths/fire/abilities/conflagration.gd"),
		"type" : "mastery"
	},
	"undying_flames" : {
		"script" : preload("res://paths/fire/abilities/undying_flames.gd"),
		"type" : "mastery"
	},
	"white_hot" : {
		"script" : preload("res://paths/fire/abilities/white_hot.gd"),
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
	"burn" : {
		"script" : preload("res://paths/fire/burn.gd"),
		"type" : "status"
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
	"chill" : {
		"script" : preload("res://paths/ice/chill.gd"),
		"type" : "status"
	},
	"cryobombs" : {
		"script" : preload("res://paths/ice/abilities/cryobombs.gd"),
		"type" : "upgrade"
	},
	"cryonic_volatility" : {
		"script" : preload("res://paths/ice/cryobomb/cryonic_volatility.gd"),
		"type" : "token"
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
	"freeze" : {
		"script" : preload("res://paths/ice/freeze.gd"),
		"type" : "status"
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
	"shock" : {
		"script" : preload("res://paths/lightning/shock.gd"),
		"type" : "status"
	},
	"close_orbit" : {
		"script" : preload("res://paths/lightning/abilities/close_orbit.gd"),
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
	"primal_casting" : {
		"script" : preload("res://paths/life/abilities/primal_casting.gd"),
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
	"vitalism" : {
		"script" : preload("res://paths/life/abilities/vitalism.gd"),
		"type" : "mastery"
	},
	"pain_walk" : {
		"script" : preload("res://paths/life/abilities/pain_walk.gd"),
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
	"doom" : {
		"script" : preload("res://paths/death/doom.gd"),
		"type" : "status"
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
	#endregion
	#region misc
	"bonus_health" : {
		"script" : preload("res://generic/abilities/bonus_health.gd"),
		"type" : "token"
	},
	"dark_price" : {
		"script" : preload("res://generic/abilities/dark_price.gd"),
		"type" : "token"
	},
	"haste" : {
		"script" : preload("res://generic/abilities/status/haste.gd"),
		"type" : "status"
	},
	#endregion
}
