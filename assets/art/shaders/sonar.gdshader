shader_type spatial;
uniform float time_mod_1s;
uniform sampler2D background;
uniform vec3 points[256];
uniform vec3 point_color;
uniform vec3 sweep_color;
uniform float k;
uniform float sweep_angle;
uniform float point_radius;
void vertex() {
	// Called for every vertex the material is visible on.
}
float sigmoid(float x){
	return 1.0/(1.0+exp(-x));
}
void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO=texture(background, UV).rgb;
	vec2 XY=UV*2.0-1.0;
	
	float theta=time_mod_1s*2.0*PI;
	vec2 ray=vec2(cos(theta), sin(theta));
	for(int i=1; i<256; ++i){
		vec3 XY2=points[i];
		if(length(XY-XY2.xy)<max(0.06,XY2.z)){
			float atten=1.0/(1.0+pow(length((XY.rg-XY2.rg)),2.0));
			if(dot(ray,normalize(XY2.xy))>1.0-sweep_angle){
				ALBEDO=max(ALBEDO, point_color.rgb*(atten*0.7+0.3));
			}
		}
	}
	EMISSION=vec3(pow(ALBEDO.r,2.2),pow(ALBEDO.g,2.2),pow(ALBEDO.b,2.2));
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
