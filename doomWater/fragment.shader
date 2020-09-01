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

void main()
{
    // Texel color fetching from texture sampler
	//vec2 pos2 = vec2(gl_FragCoord.x, gl_FragCoord.y) + vec(imageColor.r, imageColor.g);
    vec4 imageColor = texture(image, vec2(gl_FragCoord.x / 800, -gl_FragCoord.y / 600));
	vec2 pos2 = vec2(gl_FragCoord.x, gl_FragCoord.y) + 5 * vec2(imageColor.x, imageColor.y);
    vec4 texelColor = texture(texture0, vec2(pos2.x / 800, -pos2.y / 600));
	if(pos2.y < 300 && pos2.y > 96)
	{
		vec2 pos = vec2(pos2.x, pos2.y);
		float scale = (300 / pos2.y) * 2 - 1;
		scale = pow(scale, 2);
		pos.x += sin(pos2.x * (1/scale)*0.17f + pos2.y *(1/scale)* 0.5f + timer * (1/scale)* 8) * (((scale-1) * 1.4f)+1) - 1.5f;
		pos.y += sin(3 + pos2.x * 0.13f + pos2.y * 0.8f + timer * 2) * (((scale-1) * 0.8f)+1) - 1.5f;
		
		pos.x += (sin(pos2.x *(1/scale)* 2 + pos2.y *(1/scale)* 1 + timer *(1/scale)* 8) -1.5f) * (((scale-1) * 0.4f)+1);
		pos.y += (sin(3 + pos2.x * 3 + pos2.y * 1.4f + timer * 2) -1.5f) * (((scale-1) * 0.2f)+1);


		texelColor = texture(texture0, vec2(pos.x / 800, pos.y / 600));
		texelColor = ((vec4(0.2f,0.4f, 0.6f,1) * scale) + texelColor * 8) / (8 + scale);
		
	}
	
	/*
	const float minum =0.5f;
	if(texelColor.x > minum) texelColor.x = 1;
	else texelColor.x = 0;
	if(texelColor.y > minum) texelColor.y = 1;
	else texelColor.y = 0;
	if(texelColor.z > minum) texelColor.z = 1;
	else texelColor.z = 0;
	*/
	/*
	const int amount = 2;
	texelColor.x = 1/amount + floor(texelColor.x * amount) / amount;
	texelColor.y = 1/amount + floor(texelColor.y * amount) / amount;
	texelColor.z = 1/amount + floor(texelColor.z * amount) / amount;
	*/
	//texelColor += vec4(1,1,1,1) / distance(vec2(mouse.x, 600-mouse.y), vec2(gl_FragCoord.x, gl_FragCoord.y))); 
    // NOTE: Implement here your fragment shader code
	texelColor = texture(image, vec2(gl_FragCoord.x / 800, -gl_FragCoord.y / 600));
    finalColor = texelColor*colDiffuse;
}