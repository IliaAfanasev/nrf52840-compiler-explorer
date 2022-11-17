TOOLCHAIN_VERSION = 11.2-2022.02
NRFX_VER = 2.9.0
CMSIS_VER = 5.9.0

CC = arm-none-eabi/bin/arm-none-eabi-g++
AR = arm-none-eabi/bin/arm-none-eabi-ar

CFLAGS =
INCLUDES =
ASM_FILES =
C_FILES =
LFLAGS =
CXX_FILES =

LIB = libnrfx.a

LD_SCRIPT = linkerscript.ld

INCLUDES += -Inrfx/
INCLUDES += -Inrfx/drivers/include/
INCLUDES += -Inrfx/mdk/
INCLUDES += -Inrfx/templates/
INCLUDES += -Icmsis/CMSIS/Core/Include/

ASM_FILES += nrfx/mdk/gcc_startup_nrf52840.S
C_FILES += nrfx/mdk/system_nrf52840.c
C_FILES += nrfx/drivers/src/nrfx_uart.c

CFLAGS += -DNRFX_UART_ENABLED
CFLAGS += -DNRFX_UART0_ENABLED
CFLAGS += -DCONFIG_GPIO_AS_PINRESET
CFLAGS += -DNRF52840_XXAA
CFLAGS += -D__STARTUP_SKIP_ETEXT
CFLAGS += -D__HEAP_SIZE=8192
CFLAGS += -D__STACK_SIZE=8192
CFLAGS += -ggdb
CFLAGS += -mcpu=cortex-m4 -mthumb -mabi=aapcs -mfloat-abi=hard -mfpu=fpv4-sp-d16 
CFLAGS += -no-canonical-prefixes -fno-canonical-system-headers -ffunction-sections -fdata-sections -Wl,--gc-sections
CFLAGS += $(INCLUDES)

LFLAGS += -ggdb
LFLAGS += -mcpu=cortex-m4 -mthumb -mabi=aapcs -mfloat-abi=hard -mfpu=fpv4-sp-d16 
LFLAGS += -u_write -lnrfx
LFLAGS += -ffunction-sections -fdata-sections -Wl,--gc-sections
LFLAGS += --specs=nano.specs
LFLAGS += -T$(LD_SCRIPT)

CXX_FILES += support.cc

C_OBJS = $(C_FILES:.c=.o)
CXX_OBJS = $(CXX_FILES:.cc=.o)
ASM_OBJS = $(ASM_FILES:.S=.o)
ALL_OBJS = $(ASM_OBJS) $(C_OBJS) $(CXX_OBJS)

.PHONY: clean link compile prepare

# Compile
$(C_OBJS): %.o: %.c
$(ASM_OBJS): %.o: %.S
$(CXX_OBJS): %.o: %.cc

install:
	pip install pyserial
	pip install pyelftools

	wget https://github.com/NordicSemiconductor/nrfx/archive/refs/tags/v$(NRFX_VER).zip && \
		unzip v$(NRFX_VER).zip && \
		rm v$(NRFX_VER).zip && \
		mv nrfx-$(NRFX_VER) nrfx

	wget https://github.com/ARM-software/CMSIS_5/archive/refs/tags/$(CMSIS_VER).zip && \
		unzip $(CMSIS_VER).zip && \
		rm $(CMSIS_VER).zip && \
		mv CMSIS_5-$(CMSIS_VER) cmsis

	wget https://developer.arm.com/-/media/Files/downloads/gnu/$(TOOLCHAIN_VERSION)/binrel/gcc-arm-$(TOOLCHAIN_VERSION)-x86_64-arm-none-eabi.tar.xz && \
		tar -xf gcc-arm-$(TOOLCHAIN_VERSION)-x86_64-arm-none-eabi.tar.xz && \
		rm gcc-arm-$(TOOLCHAIN_VERSION)-x86_64-arm-none-eabi.tar.xz && \
		mv gcc-arm-$(TOOLCHAIN_VERSION)-x86_64-arm-none-eabi arm-none-eabi

	git clone https://github.com/compiler-explorer/compiler-explorer.git

	# Generate "c++.local.properties"
	echo > compiler-explorer/etc/config/c++.local.properties
	echo compilers=\&gcc >> compiler-explorer/etc/config/c++.local.properties
	echo group.gcc.compilers=arm_none_eabi >> compiler-explorer/etc/config/c++.local.properties
	echo compiler.arm_none_eabi.exe=$(shell pwd)/compiler-wrapper.sh >> compiler-explorer/etc/config/c++.local.properties
	echo compiler.arm_none_eabi.executionWrapper=$(shell pwd)/executor-wrapper.py >> compiler-explorer/etc/config/c++.local.properties
	echo compiler.arm_none_eabi.name=gcc-arm-none-eabi >> compiler-explorer/etc/config/c++.local.properties
	echo compiler.arm_none_eabi.supportsExecute=true >> compiler-explorer/etc/config/c++.local.properties
	echo compiler.arm_none_eabi.compilerType=gcc >> compiler-explorer/etc/config/c++.local.properties

	make prereqs -C compiler-explorer

run:
	make -C compiler-explorer

$(ALL_OBJS):
	@$(CC) $(CFLAGS) -O3 -fno-strict-aliasing -c $< -o $@

$(LIB): $(ALL_OBJS)
	@$(AR) rcs $@ $(ALL_OBJS)

compile:
	@$(CC) $(CFLAGS) $(ARGS)

link: $(LIB)
	@$(CC) $(LFLAGS) $(ARGS)

clean:
	@rm -rf $(ALL_OBJS) $(LIB)

uninstall: clean
	rm -rf arm-none-eabi/ nrfx/ cmsis/ compiler-explorer/
