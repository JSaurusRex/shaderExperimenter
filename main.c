#include <stdio.h>
#include <stdlib.h>
#include "raylib.h"
#include "gl.h"
//#include "glext.h"

#define GLSL_VERSION            330
int main ()
{
	InitWindow(800, 600, "Shader Experimenter");
	
	
	Texture2D tex = LoadTexture("image.png");
	Texture2D image = LoadTexture("image2.png");
	Texture2D yetanother = LoadTexture("image3.png");
	
	Shader shad = LoadShader("vertex.shader", "fragment.shader");
	int timerloc = GetShaderLocation(shad, "timer");
	int texLoc = glGetUniformLocation(shad.id, "texture1");
	int renLoc = glGetUniformLocation(shad.id, "renderTexture");
	int mouseloc = GetShaderLocation(shad, "mouse");
	SetTargetFPS(60);
	float timer = 0;
	Vector2 mousePos;
	RenderTexture2D renTex = LoadRenderTexture(800,600);
	RenderTexture2D ren2Tex = LoadRenderTexture(800,600);
	RenderTexture2D rentmp;
	while (!WindowShouldClose()) {
		
		timer += GetFrameTime();
		mousePos = GetMousePosition();
		SetShaderValue(shad, timerloc, &timer, UNIFORM_FLOAT);
		rentmp = renTex;
		renTex = ren2Tex;
		ren2Tex = rentmp;
		BeginDrawing();
			ClearBackground(BLACK);
			BeginTextureMode(ren2Tex);
				BeginShaderMode(shad);
					glActiveTexture(GL_TEXTURE1);
					glBindTexture(GL_TEXTURE_2D,image.id);
					glUniform1i(texLoc, 1);
					glActiveTexture(GL_TEXTURE2);
					glBindTexture(GL_TEXTURE_2D,yetanother.id);
					glUniform1i(renLoc, 1);
					DrawTextureRec(tex, (Rectangle){ 0, 0, 800, 600 }, (Vector2){ 0, 0 }, WHITE);
				EndShaderMode();
			EndTextureMode();
			DrawTextureRec(ren2Tex.texture, (Rectangle){ 0, 0, renTex.texture.width, -renTex.texture.height }, (Vector2){ 0, 0 }, WHITE);
			DrawFPS(5,5);
		EndDrawing();
	}
	
	UnloadTexture(tex);
	UnloadTexture(image);
	UnloadShader(shad);
	CloseWindow();
	return 0;
	
}