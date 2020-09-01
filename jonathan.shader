#version 330

// Input vertex attributes (from vertex shader)
in vec2 fragTexCoord;
in vec4 fragColor;


// Input uniform values
uniform sampler2D texture0;
uniform vec4 colDiffuse;
uniform float timer;
uniform sampler2D image;
uniform vec2 mouse;


// Output fragment color
out vec4 finalColor;

// NOTE: Add here your custom variables
float dist(float x1, float y1, float x2, float y2) {
	return distance(vec2(x1, y1), vec2(x2, y2));
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main()
{
	float time = timer*3;
	float x = gl_FragCoord.x*.3;
	float y = gl_FragCoord.y*.3;
	float value = sin(dist(x + time, y, 128.0, 128.0) / 8.0)
             + sin(dist(x, y, 64.0, 64.0) / 8.0)
             + sin(dist(x, y + time / 7, 192.0, 64) / 7.0)
             + sin(dist(x, y, 192.0, 100.0) / 8.0);
	
    finalColor = vec4(hsv2rgb(vec3(mod(value*.7, 1), 1, 1)), 1);
}
