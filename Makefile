OBJS += console.o
OBJS += vectors.o
#OBJS += led.o
OBJS += floppy.o
OBJS += backlight.o
OBJS += ili9341.o
OBJS += xpt2046.o
OBJS += font8x8.o
OBJS += main.o
OBJS += sd_spi.o
OBJS += spi.o
OBJS += string.o
OBJS += stm32f10x.o
#OBJS += usb_hcd.o
OBJS += util.o
SUBDIRS += fatfs

PROJ = gotek

.PHONY: all clean flash start serial

ifneq ($(RULES_MK),y)

export ROOT := $(CURDIR)

all clean:
	$(MAKE) -f Rules.mk $@

else

all: $(PROJ).elf $(PROJ).bin $(PROJ).hex

endif

FLASH=0x8000000
BAUD=921600

flash: all
	sudo ~/stm32flash/stm32flash -S $(FLASH) -g $(FLASH) \
	-b $(BAUD) -v -w $< /dev/ttyUSB0

start:
	sudo ~/stm32flash/stm32flash -b $(BAUD) -g $(FLASH) /dev/ttyUSB0

serial:
	sudo miniterm.py --baud=3000000 /dev/ttyUSB0
