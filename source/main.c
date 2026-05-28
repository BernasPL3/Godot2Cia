#include <3ds.h>
#include <stdio.h>

#include "ui.h"
#include "file_browser.h"
#include "zip.h"
#include "cia_builder.h"
#include "godot_parser.h"

int main() {

    gfxInitDefault();
    consoleInit(GFX_TOP, NULL);

    drawMenu();

    while (aptMainLoop()) {

        hidScanInput();

        u32 kDown = hidKeysDown();

        if (kDown & KEY_START)
            break;

        if (kDown & KEY_A) {

            printf("\nAbrindo SD...\n");

            listFiles("sdmc:/");
        }

        if (kDown & KEY_B) {

            compressProject("MeuProjetoGodot");
        }

        if (kDown & KEY_X) {

            buildCIA("MeuProjetoGodot");
        }

        if (kDown & KEY_Y) {

            parseGodotProject("sdmc:/project.godot");
        }

        gfxFlushBuffers();
        gfxSwapBuffers();
        gspWaitForVBlank();
    }

    gfxExit();

    return 0;
}
