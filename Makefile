ASM=nasm

SRC_DIR=src
BUILD_DIR=build

.PHONY: all floppy_image kernelis bootloaderis clean always

floppy_image: $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main_floppy.img: bootloaderis kernelis
	dd if=/dev/zero of=$(BUILD_DIR)/main_floppy.img bs=512 count=2880
	mkfs.fat -F12 -n "VIEVERSYSOS" $(BUILD_DIR)/main_floppy.img
	dd if=$(BUILD_DIR)/bootloaderis.bin of=$(BUILD_DIR)/main_floppy.img conv=notrunc
	mcopy -i $(BUILD_DIR)/main_floppy.img $(BUILD_DIR)/kernelis.bin "::kernelis.bin"

bootloaderis: $(BUILD_DIR)/bootloaderis.bin

$(BUILD_DIR)/bootloaderis.bin: always
	$(ASM) $(SRC_DIR)/bootloaderis/boot.asm -fbin -o $(BUILD_DIR)/bootloaderis.bin

kernelis: $(BUILD_DIR)/kernelis.bin


$(BUILD_DIR)/kernelis.bin: always
	$(ASM) $(SRC_DIR)/kernelis/main.asm -fbin -o $(BUILD_DIR)/kernelis.bin

always:
	mkdir -p $(BUILD_DIR)

clean:
	rm -fr $(BUILD_DIR)/*
