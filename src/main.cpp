#include "external/raylib/raylib.h"
#include "gui/window.hpp"

int main(void) {
    InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Armored Havoc");
    SetTargetFPS(60);

    // Main game loop
    while(!WindowShouldClose()) {       // Detect window close button or ESC key
        BeginDrawing();
        ClearBackground(BLACK);

        EndDrawing();
    }
    CloseWindow();
    return 0;
}