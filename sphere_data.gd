extends Node

var room_data = {
	#region tutorial
	"tutorial_entrance_hall" : {
		"scene" : preload("res://tutorial/region/rooms/tutorial_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"tutorial_room_0" : {
		"scene" : preload("res://tutorial/region/rooms/tutorial_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"tutorial_room_1" : {
		"scene" : preload("res://tutorial/region/rooms/tutorial_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"tutorial_room_2" : {
		"scene" : preload("res://tutorial/region/rooms/tutorial_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"tutorial_throne_room" : {
		"scene" : preload("res://tutorial/region/rooms/tutorial_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
		"challenge" : true,
	},
	#endregion
	#region vasis
	"vasis_entrance_hall" : {
		"scene" : preload("res://spheres/1/vasis/rooms/vasis_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_room_0" : {
		"scene" : preload("res://spheres/1/vasis/rooms/vasis_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_room_1" : {
		"scene" : preload("res://spheres/1/vasis/rooms/vasis_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_room_2" : {
		"scene" : preload("res://spheres/1/vasis/rooms/vasis_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_throne_room" : {
		"scene" : preload("res://spheres/1/vasis/rooms/vasis_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
		"challenge" : true,
	},
	#endregion
	#region thayma
	"thayma_entrance_hall" : {
		"scene" : preload("res://spheres/2/thayma/rooms/thayma_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_room_0" : {
		"scene" : preload("res://spheres/2/thayma/rooms/thayma_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_health_treasury" : {
		"scene" : preload("res://spheres/2/thayma/rooms/thayma_health_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_qualia_treasury" : {
		"scene" : preload("res://spheres/2/thayma/rooms/thayma_qualia_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_room_1" : {
		"scene" : preload("res://spheres/2/thayma/rooms/thayma_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_room_2" : {
		"scene" : preload("res://spheres/2/thayma/rooms/thayma_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_throne_room" : {
		"scene" : preload("res://spheres/2/thayma/rooms/thayma_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
		"challenge" : true,
	},
	#endregion
	#region aporia
	"aporia_entrance_hall" : {
		"scene" : preload("res://spheres/3/aporia/rooms/aporia_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	"aporia_room_0" : {
		"scene" : preload("res://spheres/3/aporia/rooms/aporia_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	"aporia_health_treasury" : {
		"scene" : preload("res://spheres/3/aporia/rooms/aporia_health_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	"aporia_qualia_treasury" : {
		"scene" : preload("res://spheres/3/aporia/rooms/aporia_qualia_treasury.tscn"), 
		"zoom_scale" : 0.8, 
		"region" : "aporia",
	},
	"aporia_room_1" : {
		"scene" : preload("res://spheres/3/aporia/rooms/aporia_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	"aporia_room_2" : {
		"scene" : preload("res://spheres/3/aporia/rooms/aporia_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	"aporia_throne_room" : {
		"scene" : preload("res://spheres/3/aporia/rooms/aporia_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
		"challenge" : true,
	},
	#endregion
	#region olethros
	"olethros_entrance_hall" : {
		"scene" : preload("res://spheres/4/olethros/rooms/olethros_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_room_0" : {
		"scene" : preload("res://spheres/4/olethros/rooms/olethros_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_health_treasury" : {
		"scene" : preload("res://spheres/4/olethros/rooms/olethros_health_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_qualia_treasury" : {
		"scene" : preload("res://spheres/4/olethros/rooms/olethros_qualia_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_room_1" : {
		"scene" : preload("res://spheres/4/olethros/rooms/olethros_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_room_2" : {
		"scene" : preload("res://spheres/4/olethros/rooms/olethros_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_throne_room" : {
		"scene" : preload("res://spheres/4/olethros/rooms/olethros_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
		"challenge" : true,
	},
	#endregion
	#region anapnoi
	"anapnoi_entrance_hall" : {
		"scene" : preload("res://spheres/5/anapnoi/rooms/anapnoi_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
	},
	"anapnoi_room_0" : {
		"scene" : preload("res://spheres/5/anapnoi/rooms/anapnoi_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
	},
	"anapnoi_health_treasury" : {
		"scene" : preload("res://spheres/5/anapnoi/rooms/anapnoi_health_treasury.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
	},
	"anapnoi_qualia_treasury" : {
		"scene" : preload("res://spheres/5/anapnoi/rooms/anapnoi_qualia_treasury.tscn"), 
		"zoom_scale" : 1, 
		"region" : "anapnoi",
	},
	"anapnoi_room_1" : {
		"scene" : preload("res://spheres/5/anapnoi/rooms/anapnoi_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
	},
	"anapnoi_room_2" : {
		"scene" : preload("res://spheres/5/anapnoi/rooms/anapnoi_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
	},
	"anapnoi_throne_room" : {
		"scene" : preload("res://spheres/5/anapnoi/rooms/anapnoi_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
		"challenge" : true,
	},
	#endregion
	#region misc
	"debug_room" : {
		"scene" : preload("res://spheres/debug_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "pandemonium",
		"challenge" : true,
	},
	#endregion
}

var entity_data = {
	#region vasis
	"leaper" : {
		"scene" : preload("res://spheres/1/vasis/leaper/leaper.tscn")
	},
	"spitter" : {
		"scene" : preload("res://spheres/1/vasis/spitter/spitter.tscn")
	},
	"giga_leaper" : {
		"scene" : preload("res://spheres/1/vasis/giga_leaper/giga_leaper.tscn")
	},
	"giga_spitter" : {
		"scene" : preload("res://spheres/1/vasis/giga_spitter/giga_spitter.tscn")
	},
	#endregion
	#region thayma
	"spitball" : {
		"scene" : preload("res://spheres/2/thayma/spitball/spitball.tscn")
	},
	"mars" : {
		"scene" : preload("res://spheres/2/thayma/mars/mars.tscn")
	},
	"trispitter" : {
		"scene" : preload("res://spheres/2/thayma/trispitter/trispitter.tscn")
	},
	"saturn" : {
		"scene" : preload("res://spheres/2/thayma/saturn/saturn.tscn")
	},
	#endregion
	#region aporia
	"mold" : {
		"scene" : preload("res://spheres/3/aporia/mold/mold.tscn")
	},
	"leaker" : {
		"scene" : preload("res://spheres/3/aporia/leaker/leaker.tscn")
	},
	"breaker" : {
		"scene" : preload("res://spheres/3/aporia/breaker/breaker.tscn")
	},
	"mold_mother" : {
		"scene" : preload("res://spheres/3/aporia/mold_mother/mold_mother.tscn")
	},
	#endregion
	#region olethros
	"griefer" : {
		"scene" : preload("res://spheres/4/olethros/griefer/griefer.tscn")
	},
	"rocketjumper" : {
		"scene" : preload("res://spheres/4/olethros/rocketjumper/rocketjumper.tscn")
	},
	"meteor" : {
		"scene" : preload("res://spheres/4/olethros/meteor/meteor.tscn")
	},
	"harbinger" : {
		"scene" : preload("res://spheres/4/olethros/harbinger/harbinger.tscn")
	},
	#endregion
	#region anapnoi
	"sprout" : {
		"scene" : preload("res://spheres/5/anapnoi/sprout/sprout.tscn")
	},
	"stalk" : {
		"scene" : preload("res://spheres/5/anapnoi/stalk/stalk.tscn")
	},
	"hydra" : {
		"scene" : preload("res://spheres/5/anapnoi/hydra/hydra.tscn")
	},
	"gall" : {
		"scene" : preload("res://spheres/5/anapnoi/gall/gall.tscn")
	},
	"giga_sprout" : {
		"scene" : preload("res://spheres/5/anapnoi/giga_sprout/giga_sprout.tscn")
	},
	#endregion
}
