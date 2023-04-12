shader_type canvas_item;

uniform vec4 color_tint : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {

	vec4 pixelColor = texture(TEXTURE, UV);
	COLOR = vec4(pixelColor.r * color_tint.x, pixelColor.g* color_tint.g, pixelColor.b* color_tint.b, pixelColor.a);
}
