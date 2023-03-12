CFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles



####################################### make

# all: clean kernel8.img
all: kernel8.img

start.o: start.S
	aarch64-linux-gnu-gcc $(CFLAGS) -c start.S -o start.o

kernel8.img: start.o
	aarch64-linux-gnu-ld -nostdlib -nostartfiles start.o -T link.ld -o kernel8.elf
	aarch64-linux-gnu-objcopy -O binary kernel8.elf kernel8.img


####################################### make clean

clean:
	rm kernel8.elf *.o >/dev/null 2>/dev/null || true

####################################### make run

run:
	qemu-system-aarch64 -M raspi3 -kernel kernel8.img -d in_asm