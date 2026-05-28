CC = arm-none-eabi-gcc

TARGET = Godot2CIA

SRC = \
source/main.c \
source/ui.c \
source/zip.c \
source/cia_builder.c \
source/godot_parser.c \
source/file_browser.c

CFLAGS = \
-Wall \
-O2 \
-Iinclude \
-march=armv6k \
-mtune=mpcore \
-mfloat-abi=hard

LIBS = -lctru

all:
	$(CC) $(SRC) $(CFLAGS) $(LIBS) -o $(TARGET).elf
	3dsxtool $(TARGET).elf $(TARGET).3dsx

clean:
	rm -f *.elf
	rm -f *.3dsx
