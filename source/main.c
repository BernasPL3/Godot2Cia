#include <3ds.h>
#include <stdio.h>

int main() {

    gfxInitDefault();
    consoleInit(GFX_TOP, NULL);

    printf("Godot2CIA iniciado!\n");

    while (aptMainLoop()) {

        hidScanInput();
        u32 kDown = hidKeysDown();

        if (kDown & KEY_A) {
            printf("Abrindo navegador...\n");
        }

        if (kDown & KEY_B) {
            printf("Compactando projeto...\n");
        }

        if (kDown & KEY_X) {
            printf("Gerando CIA...\n");
        }

        if (kDown & KEY_Y) {
            printf("Abrindo configuracoes...\n");
        }

        if (kDown & KEY_START)
            break;

        gfxFlushBuffers();
        gfxSwapBuffers();
        gspWaitForVBlank();
    }

    gfxExit();
    return 0;
}
