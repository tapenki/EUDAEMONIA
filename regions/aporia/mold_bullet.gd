extends Projectile

var wobble = 0

func movement(delta):
	var old_position = global_position
	wobble += delta * ability_handler.speed_scale * 10
	translate((velocity * delta * ability_handler.speed_scale).rotated(sin(wobble)*0.75))
	ability_handler.movement.emit(old_position.distance_to(global_position))
