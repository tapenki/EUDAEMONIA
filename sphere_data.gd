extends Node

var room_data = {
	#region tutorial
	"tutorial_entrance_hall" : {
		"scene" : preload("res://tutorial/land/rooms/tutorial_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
	},
	"tutorial_room_0" : {
		"scene" : preload("res://tutorial/land/rooms/tutorial_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
	},
	"tutorial_room_1" : {
		"scene" : preload("res://tutorial/land/rooms/tutorial_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
	},
	"tutorial_room_2" : {
		"scene" : preload("res://tutorial/land/rooms/tutorial_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
	},
	"tutorial_throne_room" : {
		"scene" : preload("res://tutorial/land/rooms/tutorial_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
		"challenge" : true,
	},
	#endregion
	#region steps
	"steps_entrance_hall" : {
		"scene" : preload("res://spheres/1/steps/rooms/steps_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
	},
	"steps_room_0" : {
		"scene" : preload("res://spheres/1/steps/rooms/steps_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
	},
	"steps_room_1" : {
		"scene" : preload("res://spheres/1/steps/rooms/steps_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
	},
	"steps_room_2" : {
		"scene" : preload("res://spheres/1/steps/rooms/steps_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
	},
	"steps_throne_room" : {
		"scene" : preload("res://spheres/1/steps/rooms/steps_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "steps",
		"challenge" : true,
	},
	#endregion
	#region depths
	"depths_entrance_hall" : {
		"scene" : preload("res://spheres/2/depths/rooms/depths_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "depths",
	},
	"depths_room_0" : {
		"scene" : preload("res://spheres/2/depths/rooms/depths_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "depths",
	},
	"depths_health_treasury" : {
		"scene" : preload("res://spheres/2/depths/rooms/depths_health_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "depths",
	},
	"depths_damage_treasury" : {
		"scene" : preload("res://spheres/2/depths/rooms/depths_damage_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "depths",
	},
	"depths_room_1" : {
		"scene" : preload("res://spheres/2/depths/rooms/depths_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "depths",
	},
	"depths_room_2" : {
		"scene" : preload("res://spheres/2/depths/rooms/depths_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "depths",
	},
	"depths_throne_room" : {
		"scene" : preload("res://spheres/2/depths/rooms/depths_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "depths",
	},
	#endregion
	#region wonder
	"wonder_entrance_hall" : {
		"scene" : preload("res://spheres/3/wonder/rooms/wonder_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "wonder",
	},
	"wonder_room_0" : {
		"scene" : preload("res://spheres/3/wonder/rooms/wonder_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "wonder",
	},
	"wonder_health_treasury" : {
		"scene" : preload("res://spheres/3/wonder/rooms/wonder_health_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "wonder",
	},
	"wonder_damage_treasury" : {
		"scene" : preload("res://spheres/3/wonder/rooms/wonder_damage_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "wonder",
	},
	"wonder_room_1" : {
		"scene" : preload("res://spheres/3/wonder/rooms/wonder_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "wonder",
	},
	"wonder_room_2" : {
		"scene" : preload("res://spheres/3/wonder/rooms/wonder_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "wonder",
	},
	"wonder_throne_room" : {
		"scene" : preload("res://spheres/3/wonder/rooms/wonder_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "wonder",
		"challenge" : true,
	},
	#endregion
	#region doubt
	"doubt_entrance_hall" : {
		"scene" : preload("res://spheres/3/doubt/rooms/doubt_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "doubt",
	},
	"doubt_room_0" : {
		"scene" : preload("res://spheres/3/doubt/rooms/doubt_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "doubt",
	},
	"doubt_health_treasury" : {
		"scene" : preload("res://spheres/3/doubt/rooms/doubt_health_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "doubt",
	},
	"doubt_damage_treasury" : {
		"scene" : preload("res://spheres/3/doubt/rooms/doubt_damage_treasury.tscn"), 
		"zoom_scale" : 0.8, 
		"land" : "doubt",
	},
	"doubt_room_1" : {
		"scene" : preload("res://spheres/3/doubt/rooms/doubt_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "doubt",
	},
	"doubt_room_2" : {
		"scene" : preload("res://spheres/3/doubt/rooms/doubt_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "doubt",
	},
	"doubt_throne_room" : {
		"scene" : preload("res://spheres/3/doubt/rooms/doubt_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "doubt",
		"challenge" : true,
	},
	#endregion
	#region ruin
	"ruin_entrance_hall" : {
		"scene" : preload("res://spheres/4/ruin/rooms/ruin_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "ruin",
	},
	"ruin_room_0" : {
		"scene" : preload("res://spheres/4/ruin/rooms/ruin_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "ruin",
	},
	"ruin_health_treasury" : {
		"scene" : preload("res://spheres/4/ruin/rooms/ruin_health_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "ruin",
	},
	"ruin_damage_treasury" : {
		"scene" : preload("res://spheres/4/ruin/rooms/ruin_damage_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "ruin",
	},
	"ruin_room_1" : {
		"scene" : preload("res://spheres/4/ruin/rooms/ruin_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "ruin",
	},
	"ruin_room_2" : {
		"scene" : preload("res://spheres/4/ruin/rooms/ruin_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "ruin",
	},
	"ruin_throne_room" : {
		"scene" : preload("res://spheres/4/ruin/rooms/ruin_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "ruin",
		"challenge" : true,
	},
	#endregion
	#region breath
	"breath_entrance_hall" : {
		"scene" : preload("res://spheres/5/breath/rooms/breath_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "breath",
	},
	"breath_room_0" : {
		"scene" : preload("res://spheres/5/breath/rooms/breath_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "breath",
	},
	"breath_health_treasury" : {
		"scene" : preload("res://spheres/5/breath/rooms/breath_health_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "breath",
	},
	"breath_damage_treasury" : {
		"scene" : preload("res://spheres/5/breath/rooms/breath_damage_treasury.tscn"), 
		"zoom_scale" : 1, 
		"land" : "breath",
	},
	"breath_room_1" : {
		"scene" : preload("res://spheres/5/breath/rooms/breath_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "breath",
	},
	"breath_room_2" : {
		"scene" : preload("res://spheres/5/breath/rooms/breath_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "breath",
	},
	"breath_throne_room" : {
		"scene" : preload("res://spheres/5/breath/rooms/breath_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "breath",
		"challenge" : true,
	},
	#endregion
	#region light
	"light_entrance_hall" : {
		"scene" : preload("res://spheres/6/light/rooms/light_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "light",
	},
	"light_room_0" : {
		"scene" : preload("res://spheres/6/light/rooms/light_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "light",
	},
	"light_room_1" : {
		"scene" : preload("res://spheres/6/light/rooms/light_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "light",
	},
	#endregion
	#region misc
	"debug_room" : {
		"scene" : preload("res://spheres/debug_room.tscn"), 
		"zoom_scale" : 0.9, 
		"land" : "pandemonium",
		"challenge" : true,
	},
	#endregion
}

var entity_data = {
	#region steps
	"leaper" : {
		"scene" : preload("res://spheres/1/steps/leaper/leaper.tscn")
	},
	"spitter" : {
		"scene" : preload("res://spheres/1/steps/spitter/spitter.tscn")
	},
	"giga_leaper" : {
		"scene" : preload("res://spheres/1/steps/giga_leaper/giga_leaper.tscn")
	},
	"giga_spitter" : {
		"scene" : preload("res://spheres/1/steps/giga_spitter/giga_spitter.tscn")
	},
	#endregion
	#region depths
	"diver" : {
		"scene" : preload("res://spheres/2/depths/diver/diver.tscn")
	},
	"stray_bubble" : {
		"scene" : preload("res://spheres/2/depths/stray_bubble/stray_bubble.tscn")
	},
	"sentry" : {
		"scene" : preload("res://spheres/2/depths/sentry/sentry.tscn")
	},
	"spouter" : {
		"scene" : preload("res://spheres/2/depths/spouter/spouter.tscn")
	},
	"warden" : {
		"scene" : preload("res://spheres/2/depths/warden/warden.tscn")
	},
	#endregion
	#region wonder
	"spitball" : {
		"scene" : preload("res://spheres/3/wonder/spitball/spitball.tscn")
	},
	"mars" : {
		"scene" : preload("res://spheres/3/wonder/mars/mars.tscn")
	},
	"trispitter" : {
		"scene" : preload("res://spheres/3/wonder/trispitter/trispitter.tscn")
	},
	"saturn" : {
		"scene" : preload("res://spheres/3/wonder/saturn/saturn.tscn")
	},
	#endregion
	#region doubt
	"mold" : {
		"scene" : preload("res://spheres/3/doubt/mold/mold.tscn")
	},
	"leaker" : {
		"scene" : preload("res://spheres/3/doubt/leaker/leaker.tscn")
	},
	"breaker" : {
		"scene" : preload("res://spheres/3/doubt/breaker/breaker.tscn")
	},
	"mold_mother" : {
		"scene" : preload("res://spheres/3/doubt/mold_mother/mold_mother.tscn")
	},
	#endregion
	#region ruin
	"griefer" : {
		"scene" : preload("res://spheres/4/ruin/griefer/griefer.tscn")
	},
	"rocketjumper" : {
		"scene" : preload("res://spheres/4/ruin/rocketjumper/rocketjumper.tscn")
	},
	"meteor" : {
		"scene" : preload("res://spheres/4/ruin/meteor/meteor.tscn")
	},
	"harbinger" : {
		"scene" : preload("res://spheres/4/ruin/harbinger/harbinger.tscn")
	},
	#endregion
	#region breath
	"leafer" : {
		"scene" : preload("res://spheres/5/breath/leafer/leafer.tscn")
	},
	"stalk" : {
		"scene" : preload("res://spheres/5/breath/stalk/stalk.tscn")
	},
	"hydra" : {
		"scene" : preload("res://spheres/5/breath/hydra/hydra.tscn")
	},
	"gall" : {
		"scene" : preload("res://spheres/5/breath/gall/gall.tscn")
	},
	"giga_leafer" : {
		"scene" : preload("res://spheres/5/breath/giga_leafer/giga_leafer.tscn")
	},
	#endregion
	#region light
	"blaster" : {
		"scene" : preload("res://spheres/6/light/blaster/blaster.tscn")
	},
	"disco" : {
		"scene" : preload("res://spheres/6/light/disco/disco.tscn")
	},
	"looker" : {
		"scene" : preload("res://spheres/6/light/looker/looker.tscn")
	},
	#endregion
}
