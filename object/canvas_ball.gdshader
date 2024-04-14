shader_type spatial;
render_mode blend_mix, depth_prepass_alpha;
uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	if(ALBEDO.r >= 0.6 && ALBEDO.g >= 0.6 && ALBEDO.b >= 0.6){
		ALPHA = 0.25;
	}
	else{
		ALPHA = 1.0;
	}
}
