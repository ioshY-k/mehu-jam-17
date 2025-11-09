shader_type canvas_item;

uniform float intensity : hint_range(0.0, 1.0) = 1.0; // 0 = kein Effekt, 1 = komplett farblos
// Luminanz-Gewichte (sRGB standard)
const vec3 LUMA = vec3(0.2126, 0.7152, 0.0722);

void fragment() {
    vec4 col = texture(TEXTURE, UV);
    float gray = dot(col.rgb, LUMA);
    vec3 out_rgb = mix(col.rgb, vec3(gray), intensity);
    COLOR = vec4(out_rgb, col.a);
}
