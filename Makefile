
Build: main.c
	gcc -w -g -c -I /opt/raylib/src -IraylibComplete/src/external/glfw/deps/ main.c -o ./obj/linux_platform.o
	gcc -o shaderExperimenter  obj/linux_platform.o -s -w -I/opt/raylib/src -L/opt/raylib/release/libs/linux -lraylib -lGL -lm -lpthread -ldl -lrt -lX11

debug: main.c
	gcc -ggdb -o Debug main.c -g -Wall -I/opt/raylib/src -L/opt/raylib/release/libs/linux -lraylib -lGL -lm  -lpthread -ldl -lrt -lX11
	#valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose ./Debug

windows: main.c
	x86_64-w64-mingw32-gcc main.c -o shaderExperimenter.exe -static -s -w -Iraylib/include  -IraylibComplete/src/external/glfw/deps/ -Iinclude -Lraylib/lib -Llib-mingw-w64 -lraylib_static -lglfw3 -lopengl32 -lgdi32 -lwinmm -Wl,-allow-multiple-definition -Wl,--subsystem,windows