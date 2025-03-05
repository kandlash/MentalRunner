shader_type canvas_item;

uniform float amplitude;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    color.rgb *= amplitude; // Изменяем яркость в зависимости от амплитуды
    COLOR = color;
}