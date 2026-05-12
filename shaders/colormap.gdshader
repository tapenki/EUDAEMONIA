shader_type canvas_item;

uniform vec3 color : source_color = vec3(1.0);
uniform bool colorfill = false;

void fragment() {
	if (colorfill || texture(TEXTURE, UV) == vec4(1.0, 0.0, 1.0, 1.0)) {
		COLOR.rgb = color;
	}
}