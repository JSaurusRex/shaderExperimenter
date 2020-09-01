#version 330

// Input vertex attributes (from vertex shader)
in vec2 fragTexCoord;
in vec4 fragColor;


// Input uniform values
uniform sampler2D texture0;
uniform vec4 colDiffuse;
uniform float timer;
uniform sampler2D texture1;
uniform vec2 mouse;
uniform sampler2D renderTexture;


// Output fragment color
out vec4 finalColor;

void main()
{
	
	vec2 pos = vec2(gl_FragCoord.x / 800, -gl_FragCoord.y / 600);
	vec4 normalColor = texture(texture1, pos);
	pos += vec2(normalColor.x -0.5f, normalColor.y -0.5f) * (sin(timer) + 1);
    finalColor = texture(texture0, pos);
	finalColor = mix(finalColor,texture(renderTexture, vec2(gl_FragCoord.x / 800, gl_FragCoord.y / 600)),0.5f);
}
