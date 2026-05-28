#include <3ds.h>
#include <stdio.h>
#include <dirent.h>

void listFiles(const char* path) {

    DIR* dir = opendir(path);

    if (!dir) {
        printf("Erro ao abrir pasta\n");
        return;
    }

    struct dirent* ent;

    while ((ent = readdir(dir)) != NULL) {
        printf("%s\n", ent->d_name);
    }

    closedir(dir);
}
