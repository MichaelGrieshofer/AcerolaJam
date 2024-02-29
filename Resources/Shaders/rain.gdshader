shader_type canvas_item;
uniform sampler2D screen : hint_screen_texture, filter_nearest_mipmap;
uniform float transparency = 1;
uniform vec2 offset = vec2(0,-0.015);

void fragment( )
{
	float alpha = texture(TEXTURE, UV).a;
	COLOR = texture( screen, SCREEN_UV + alpha * offset); 
	COLOR.a = COLOR.a*transparency;
}