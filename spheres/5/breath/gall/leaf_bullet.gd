extends Projectile

var wobble = 0

func calculate_movement(delta):
	wobble += delta * ability_relay.speed_scale * 10
	return global_position + (velocity * delta * ability_relay.speed_scale).rotated(sin(wobble)*0.75)
