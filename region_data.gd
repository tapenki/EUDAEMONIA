extends Node

var room_data = {
	#region vasis
	"vasis_entrance_hall" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_room_0" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_room_1" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_room_2" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_throne_room" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
		"challenge" : true,
	},
	#endregion
	#region thayma
	"thayma_entrance_hall" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_room_0" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_room_1" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_room_2" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_throne_room" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
		"challenge" : true,
	},
	#endregion
	#region aporia
	"aporia_entrance_hall" : {
		"scene" : preload("res://regions/aporia/rooms/aporia_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	"aporia_room_0" : {
		"scene" : preload("res://regions/aporia/rooms/aporia_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	"aporia_room_1" : {
		"scene" : preload("res://regions/aporia/rooms/aporia_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	"aporia_room_2" : {
		"scene" : preload("res://regions/aporia/rooms/aporia_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	"aporia_throne_room" : {
		"scene" : preload("res://regions/aporia/rooms/aporia_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
		"challenge" : true,
	},
	#endregion
	#region olethros
	"olethros_entrance_hall" : {
		"scene" : preload("res://regions/olethros/rooms/olethros_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_room_0" : {
		"scene" : preload("res://regions/olethros/rooms/olethros_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_room_1" : {
		"scene" : preload("res://regions/olethros/rooms/olethros_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_room_2" : {
		"scene" : preload("res://regions/olethros/rooms/olethros_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	"olethros_throne_room" : {
		"scene" : preload("res://regions/olethros/rooms/olethros_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
		"challenge" : true,
	},
	#endregion
	#region anapnoi
	"anapnoi_entrance_hall" : {
		"scene" : preload("res://regions/anapnoi/rooms/anapnoi_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
	},
	"anapnoi_room_0" : {
		"scene" : preload("res://regions/anapnoi/rooms/anapnoi_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
	},
	"anapnoi_room_1" : {
		"scene" : preload("res://regions/anapnoi/rooms/anapnoi_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
	},
	"anapnoi_room_2" : {
		"scene" : preload("res://regions/anapnoi/rooms/anapnoi_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
	},
	"anapnoi_throne_room" : {
		"scene" : preload("res://regions/anapnoi/rooms/anapnoi_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "anapnoi",
		"challenge" : true,
	},
	#endregion
	#region misc
	"debug_room" : {
		"scene" : preload("res://regions/debug_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "pandemonium",
		"challenge" : true,
	},
	#endregion
}

var entity_data = {
	#region vasis
	"leaper" : {
		"scene" : preload("res://regions/vasis/leaper/leaper.tscn")
	},
	"spitter" : {
		"scene" : preload("res://regions/vasis/spitter/spitter.tscn")
	},
	"giga_leaper" : {
		"scene" : preload("res://regions/vasis/giga_leaper/giga_leaper.tscn")
	},
	"giga_spitter" : {
		"scene" : preload("res://regions/vasis/giga_spitter/giga_spitter.tscn")
	},
	#endregion
	#region thayma
	"spitball" : {
		"scene" : preload("res://regions/thayma/spitball/spitball.tscn")
	},
	"mars" : {
		"scene" : preload("res://regions/thayma/mars/mars.tscn")
	},
	"trispitter" : {
		"scene" : preload("res://regions/thayma/trispitter/trispitter.tscn")
	},
	"saturn" : {
		"scene" : preload("res://regions/thayma/saturn/saturn.tscn")
	},
	#endregion
	#region aporia
	"mold" : {
		"scene" : preload("res://regions/aporia/mold/mold.tscn")
	},
	"leaker" : {
		"scene" : preload("res://regions/aporia/leaker/leaker.tscn")
	},
	"breaker" : {
		"scene" : preload("res://regions/aporia/breaker/breaker.tscn")
	},
	"mold_mother" : {
		"scene" : preload("res://regions/aporia/mold_mother/mold_mother.tscn")
	},
	#endregion
	#region olethros
	"griefer" : {
		"scene" : preload("res://regions/olethros/griefer/griefer.tscn")
	},
	"rocketjumper" : {
		"scene" : preload("res://regions/olethros/rocketjumper/rocketjumper.tscn")
	},
	"meteor" : {
		"scene" : preload("res://regions/olethros/meteor/meteor.tscn")
	},
	"harbinger" : {
		"scene" : preload("res://regions/olethros/harbinger/harbinger.tscn")
	},
	#endregion
	#region anapnoi
	"sprout" : {
		"scene" : preload("res://regions/anapnoi/sprout/sprout.tscn")
	},
	"stalk" : {
		"scene" : preload("res://regions/anapnoi/stalk/stalk.tscn")
	},
	"hydra" : {
		"scene" : preload("res://regions/anapnoi/hydra/hydra.tscn")
	},
	"gall" : {
		"scene" : preload("res://regions/anapnoi/gall/gall.tscn")
	},
	"giga_sprout" : {
		"scene" : preload("res://regions/anapnoi/giga_sprout/giga_sprout.tscn")
	},
	#endregion
}
