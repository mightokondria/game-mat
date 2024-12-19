shader_type canvas_item;

uniform vec4 target_color : source_color; // Warna asli yang akan diganti
uniform vec4 replace_color : source_color; // Warna pengganti
uniform float tolerance : hint_range(0.0, 1.0); // Toleransi warna

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float diff = distance(tex_color.rgb, target_color.rgb);

    if (diff <= tolerance) {
        vec4 blend_color = mix(tex_color, replace_color, 1.0); // Mengganti warna
        COLOR = vec4(blend_color.rgb, tex_color.a); // Pertahankan alpha asli
    } else {
        COLOR = tex_color; // Warna tidak diganti
    }
}
