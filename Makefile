#================================
# Godot2CIA Makefile
# Sem 3ds_rules
#================================

CC      := arm-none-eabi-gcc
CXX     := arm-none-eabi-g++

TARGET  := Godot2CIA

BUILD   := build
SOURCE  := source
INCLUDE := include

#--------------------------------
# Arquivos
#--------------------------------

CFILES := \
$(SOURCE)/main.c \
$(SOURCE)/ui.c \
$(SOURCE)/zip.c \
$(SOURCE)/cia_builder.c \
$(SOURCE)/godot_parser.c \
$(SOURCE)/file_browser.c

#--------------------------------
# Flags
#--------------------------------

CFLAGS := \
-Wall \
-O2 \
-mword-relocations \
-ffunction-sections \
-fdata-sections \
-fomit-frame-pointer \
-march=armv6k \
-mtune=mpcore \
-mfloat-abi=hard \
-mtp=soft \
-I$(INCLUDE)

LDFLAGS := \
-specs=3dsx.specs \
-g \
-march=armv6k \
-mtune=mpcore \
-mfloat-abi=hard

LIBS := \
-lctru \
-lcitro2d \
-lcitro3d \
-lm

#--------------------------------
# Pastas
#--------------------------------

all: directories $(TARGET).3dsx

directories:
	mkdir -p $(BUILD)

#--------------------------------
# Compilar
#--------------------------------

$(BUILD)/main.o:
	$(CC) $(CFLAGS) -c $(SOURCE)/main.c -o $(BUILD)/main.o

$(BUILD)/ui.o:
	$(CC) $(CFLAGS) -c $(SOURCE)/ui.c -o $(BUILD)/ui.o

$(BUILD)/zip.o:
	$(CC) $(CFLAGS) -c $(SOURCE)/zip.c -o $(BUILD)/zip.o

$(BUILD)/cia_builder.o:
	$(CC) $(CFLAGS) -c $(SOURCE)/cia_builder.c -o $(BUILD)/cia_builder.o

$(BUILD)/godot_parser.o:
	$(CC) $(CFLAGS) -c $(SOURCE)/godot_parser.c -o $(BUILD)/godot_parser.o

$(BUILD)/file_browser.o:
	$(CC) $(CFLAGS) -c $(SOURCE)/file_browser.c -o $(BUILD)/file_browser.o

#--------------------------------
# Linkar ELF
#--------------------------------

$(TARGET).elf:
	$(CC) \
	$(BUILD)/main.o \
	$(BUILD)/ui.o \
	$(BUILD)/zip.o \
	$(BUILD)/cia_builder.o \
	$(BUILD)/godot_parser.o \
	$(BUILD)/file_browser.o \
	$(LDFLAGS) \
	$(LIBS) \
	-o $(TARGET).elf

#--------------------------------
# Gerar 3DSX
#--------------------------------

$(TARGET).3dsx: $(TARGET).elf
	3dsxtool $(TARGET).elf $(TARGET).3dsx

#--------------------------------
# Limpar
#--------------------------------

clean:
	rm -rf $(BUILD)
	rm -f *.elf
	rm -f *.3dsx
	rm -f *.smdh

#--------------------------------
# Instalar no SD
#--------------------------------

install:
	cp $(TARGET).3dsx /Volumes/3DS/
