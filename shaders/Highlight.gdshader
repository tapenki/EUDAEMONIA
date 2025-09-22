shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);
uniform float offset : hint_range(0, 10) = 2.0;

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * offset;
	float outline = texture(TEXTURE, UV - size).a - texture(TEXTURE, UV).a;
	outline = max(outline, 0);
	COLOR = mix(COLOR, color, outline);
}