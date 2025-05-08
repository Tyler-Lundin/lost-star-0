shader_type canvas_item;

uniform float blur_amount : hint_range(0, 10) = 2.0;

void fragment() {
    vec4 color = vec4(0.0);
    vec2 pixel_size = TEXTURE_PIXEL_SIZE * blur_amount;
    
    // Simple box blur
    color += texture(TEXTURE, UV + vec2(-pixel_size.x, -pixel_size.y));
    color += texture(TEXTURE, UV + vec2(-pixel_size.x, 0));
    color += texture(TEXTURE, UV + vec2(-pixel_size.x, pixel_size.y));
    color += texture(TEXTURE, UV + vec2(0, -pixel_size.y));
    color += texture(TEXTURE, UV + vec2(0, 0));
    color += texture(TEXTURE, UV + vec2(0, pixel_size.y));
    color += texture(TEXTURE, UV + vec2(pixel_size.x, -pixel_size.y));
    color += texture(TEXTURE, UV + vec2(pixel_size.x, 0));
    color += texture(TEXTURE, UV + vec2(pixel_size.x, pixel_size.y));
    
    color /= 9.0;
    COLOR = color;
} 