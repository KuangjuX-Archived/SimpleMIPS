.PHONY: mem clean help

ifndef CROSS_COMPILE
CROSS_COMPILE := mips-sde-elf-
endif
ifndef TESTCASE_SRC_DIR
TESTCASE_SRC_DIR := src/
endif
ifndef TESTCASE_BUILD_DIR
TESTCASE_BUILD_DIR := build/
endif
DEBUG := false

CC :=  $(CROSS_COMPILE)gcc
AS := $(CROSS_COMPILE)as
LD := $(CROSS_COMPILE)ld
OBJCOPY := $(CROSS_COMPILE)objcopy
OBJDUMP := $(CROSS_COMPILE)objdump

CFLAGS := -mips1

ifeq ($(DEBUG), true)
CFLAGS += -g
endif


OBJECTS := $(TESTCASE_BUILD_DIR)$(USER_PROGRAM).o

export	CROSS_COMPILE
export	TESTCASE_SRC_DIR
export	TESTCASE_BUILD_DIR

# ********************
# Rules of Compilation
# ********************

all: $(TESTCASE_BUILD_DIR)$(USER_PROGRAM).bin $(TESTCASE_BUILD_DIR)$(USER_PROGRAM).data convert
	./convert $(TESTCASE_BUILD_DIR)$(USER_PROGRAM).bin $(TESTCASE_BUILD_DIR)$(USER_PROGRAM).data
	mv $(USER_PROGRAM).S start.o convert $(TESTCASE_BUILD_DIR)
	mv inst_rom.mif $(TESTCASE_BUILD_DIR)$(USER_PROGRAM)_inst.mif
	mv inst_rom.coe $(TESTCASE_BUILD_DIR)$(USER_PROGRAM)_inst.coe
	mv data_ram.mif $(TESTCASE_BUILD_DIR)$(USER_PROGRAM)_data.mif
	mv data_ram.coe $(TESTCASE_BUILD_DIR)$(USER_PROGRAM)_data.coe

$(USER_PROGRAM).S: $(TESTCASE_SRC_DIR)$(USER_PROGRAM).c
	$(CC) -S $(CFLAGS) $< -o $@

start.o: start.S
	$(AS) $(CFLAGS) $< -o $@

$(TESTCASE_BUILD_DIR)$(USER_PROGRAM).o: $(USER_PROGRAM).S
	$(AS) $(CFLAGS) $< -o $@

$(TESTCASE_BUILD_DIR)$(USER_PROGRAM): default.ld $(OBJECTS) start.o
	$(LD) -T default.ld $(CFLAGS) start.o $(OBJECTS) -o $@
	$(OBJDUMP) -alD $@ > $@.asm

$(TESTCASE_BUILD_DIR)$(USER_PROGRAM).bin: $(TESTCASE_BUILD_DIR)$(USER_PROGRAM)
	$(OBJCOPY) -O binary -j .text $<  $@

$(TESTCASE_BUILD_DIR)$(USER_PROGRAM).data: $(TESTCASE_BUILD_DIR)$(USER_PROGRAM)
	$(OBJCOPY) -O binary -j .data $<  $@

convert: convert.c
	gcc $< -o $@

help: 
	@echo "用法：make USER_PROGRAM=待编译的文件 <DEBUG=[true|false]>"
	@echo "< >为可选项"

clean:
	cd $(TESTCASE_BUILD_DIR) && rm -f *
