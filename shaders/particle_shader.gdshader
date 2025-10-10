// NOTE: Shader automatically converted from Godot Engine 4.5.stable's ParticleProcessMaterial.

shader_type particles;
render_mode disable_velocity;

uniform vec3 direction;
uniform float spread;
uniform float initial_linear_velocity_min;
uniform float initial_linear_velocity_max;
uniform float directional_velocity_min;
uniform float directional_velocity_max;
//uniform float angular_velocity_min;
//uniform float angular_velocity_max;
uniform float linear_accel_min;
uniform float linear_accel_max;
uniform float damping_min;
uniform float damping_max;
uniform float initial_angle_min;
uniform float initial_angle_max;
uniform float scale_min;
uniform float scale_max;
uniform float lifetime_randomness;
uniform vec3 emission_shape_offset = vec3(0.0);
uniform vec3 emission_shape_scale = vec3(1.0);
uniform sampler2D scale_curve : repeat_disable;

float rand_from_seed(inout uint seed) {
	int k;
	int s = int(seed);
	if (s == 0) {
		s = 305420679;
	}
	k = s / 127773;
	s = 16807 * (s - k * 127773) - 2836 * k;
	if (s < 0) {
		s += 2147483647;
	}
	seed = uint(s);
	return float(seed % uint(65536)) / 65535.0;
}

float rand_from_seed_m1_p1(inout uint seed) {
	return rand_from_seed(seed) * 2.0 - 1.0;
}

uint hash(uint x) {
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = (x >> uint(16)) ^ x;
	return x;
}

struct DisplayParameters {
	vec3 scale;
	float lifetime;
	float emission_texture_position;
};

struct DynamicsParameters {
	float angle;
	//float angular_velocity;
	float initial_velocity_multiplier;
	float directional_velocity;
};

struct PhysicalParameters {
	float linear_accel;
	float damping;
};

void calculate_initial_physical_params(inout PhysicalParameters params, inout uint alt_seed) {
	params.linear_accel = mix(linear_accel_min, linear_accel_max, rand_from_seed(alt_seed));
	params.damping = mix(damping_min, damping_max, rand_from_seed(alt_seed));
}

void calculate_initial_dynamics_params(inout DynamicsParameters params, inout uint alt_seed) {
	// -------------------- DO NOT REORDER OPERATIONS, IT BREAKS VISUAL COMPATIBILITY
	// -------------------- ADD NEW OPERATIONS AT THE BOTTOM
	params.angle = mix(initial_angle_min, initial_angle_max, rand_from_seed(alt_seed));
	//params.angular_velocity = mix(angular_velocity_min, angular_velocity_max, rand_from_seed(alt_seed));
	params.initial_velocity_multiplier = mix(initial_linear_velocity_min, initial_linear_velocity_max, rand_from_seed(alt_seed));
	params.directional_velocity = mix(directional_velocity_min, directional_velocity_max, rand_from_seed(alt_seed));
}

void calculate_initial_display_params(inout DisplayParameters params, inout uint alt_seed) {
	// -------------------- DO NOT REORDER OPERATIONS, IT BREAKS VISUAL COMPATIBILITY
	// -------------------- ADD NEW OPERATIONS AT THE BOTTOM
	params.scale = vec3(mix(scale_min, scale_max, rand_from_seed(alt_seed)));
	params.scale = sign(params.scale) * max(abs(params.scale), 0.001);
	params.lifetime = (1.0 - lifetime_randomness * rand_from_seed(alt_seed));
}

void process_display_param(inout DisplayParameters params, float lifetime) {
	// Compile-time add textures.
	params.scale *= texture(scale_curve, vec2(lifetime)).rgb;
}

vec3 calculate_initial_position(inout DisplayParameters params, inout uint alt_seed) {
	vec3 pos = vec3(0.0);
	{ // Emission shape.
	 	pos = vec3(0.0);
	}
	return pos * emission_shape_scale + emission_shape_offset;
}

vec3 get_random_direction_from_spread(inout uint alt_seed, float spread_angle) {
	float pi = 3.14159;
	float degree_to_rad = pi / 180.0;
	float spread_rad = spread_angle * degree_to_rad;
	float angle1_rad = rand_from_seed_m1_p1(alt_seed) * spread_rad;
	angle1_rad += direction.x != 0.0 ? atan(direction.y, direction.x) : sign(direction.y) * (pi / 2.0);
	vec3 spread_direction = vec3(cos(angle1_rad), sin(angle1_rad), 0.0);
	return spread_direction;
}

void start() {
	uint base_number = NUMBER;
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	DisplayParameters params;
	calculate_initial_display_params(params, alt_seed);
	// Reset alt seed?
	//alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	DynamicsParameters dynamic_params;
	calculate_initial_dynamics_params(dynamic_params, alt_seed);
	PhysicalParameters physics_params;
	calculate_initial_physical_params(physics_params, alt_seed);
	process_display_param(params, 0.0);
	if (rand_from_seed(alt_seed) > AMOUNT_RATIO) {
		ACTIVE = false;
	}

	if (RESTART_ROT_SCALE) {
		TRANSFORM[0].xyz = vec3(1.0, 0.0, 0.0);
		TRANSFORM[1].xyz = vec3(0.0, 1.0, 0.0);
		//TRANSFORM[2].xyz = vec3(0.0, 0.0, 1.0);
	}
	if (RESTART_CUSTOM) {
		CUSTOM = vec4(0.0);
		CUSTOM.x = length(TRANSFORM[0].xy);
		CUSTOM.y = length(TRANSFORM[1].xy);
		CUSTOM.w = params.lifetime;
	}
	if (RESTART_POSITION) {
		TRANSFORM[3].xyz = calculate_initial_position(params, alt_seed);
	}
	if (RESTART_VELOCITY) {
		VELOCITY = get_random_direction_from_spread(alt_seed, spread) * dynamic_params.initial_velocity_multiplier;
	}
	VELOCITY.xy *= CUSTOM.xy;
	
	process_display_param(params, 0.0);
	params.scale.x *= CUSTOM.x;
	params.scale.y *= CUSTOM.y;
	//VELOCITY.z = 0.0;
	//TRANSFORM[3].z = 0.0;
}

void process() {
	uint base_number = NUMBER;
	//if (repeatable) {
	//	base_number = INDEX;
	//}
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	DisplayParameters params;
	calculate_initial_display_params(params, alt_seed);
	DynamicsParameters dynamic_params;
	calculate_initial_dynamics_params(dynamic_params, alt_seed);
	PhysicalParameters physics_params;
	calculate_initial_physical_params(physics_params, alt_seed);

	//float pi = 3.14159;
	//float degree_to_rad = pi / 180.0;

	CUSTOM.z += DELTA / LIFETIME;
	CUSTOM.z = mix(CUSTOM.z, 1.0, INTERPOLATE_TO_END);
	float lifetime_percent = CUSTOM.z / params.lifetime;
	if (CUSTOM.z > CUSTOM.w) {
		ACTIVE = false;
	}

	vec3 force;
	{
		// Copied from previous version.
		force = vec3(0.0);
		// Apply linear acceleration.
		force += length(VELOCITY) > 0.0 ? normalize(VELOCITY) * physics_params.linear_accel : vec3(0.0);
		// Apply attractor forces.
		VELOCITY += force * DELTA;
	}
	{
		// Copied from previous version.
		if (physics_params.damping > 0.0) {
			float v = length(VELOCITY);
			v -= physics_params.damping * DELTA;
			if (v < 0.0) {
				VELOCITY = vec3(0.0);
			} else {
				VELOCITY = normalize(VELOCITY) * v;
			}
		}
	}

	TRANSFORM[3].xyz += VELOCITY * DELTA;

	process_display_param(params, lifetime_percent);
	params.scale.x *= CUSTOM.x;
	params.scale.y *= CUSTOM.y;
	
	//float base_angle = dynamic_params.angle;
	//base_angle += CUSTOM.z * LIFETIME * dynamic_params.angular_velocity;
	//CUSTOM.x = base_angle * degree_to_rad;

	TRANSFORM[0] = vec4(cos(dynamic_params.angle), -sin(dynamic_params.angle), 0.0, 0.0);
	TRANSFORM[1] = vec4(sin(dynamic_params.angle), cos(dynamic_params.angle), 0.0, 0.0);
	//TRANSFORM[2] = vec4(0.0, 0.0, 1.0, 0.0);
	//TRANSFORM[3].z = 0.0;

	float scale_sign_x = params.scale.x < 0.0 ? -1.0 : 1.0;
	float scale_sign_y = params.scale.y < 0.0 ? -1.0 : 1.0;
	//float scale_sign_z = params.scale.z < 0.0 ? -1.0 : 1.0;
	float scale_minimum = 0.001;
	TRANSFORM[0].xyz *= scale_sign_x * max(abs(params.scale.x), scale_minimum);
	TRANSFORM[1].xyz *= scale_sign_y * max(abs(params.scale.y), scale_minimum);
	//TRANSFORM[2].xyz *= scale_sign_z * max(abs(params.scale.z), scale_minimum);
}