// AARCH64 Assembly Tutorial (https://www.youtube.com/watch?v=8NdrdxkBP3U)
//
// COMPILE
//   aarch64-linux-gnu-as 01_doNothing.asm -o 01_doNothing.out
//
// LINK into an executable
//   aarch64-linux-gnu-gcc 01_doNothing.out -o 01_doNothing.elf -nostdlib -static
//
// EXECUTE
//   qemu-aarch64 ./01_doNothing.elf


.global _start

.section .text
_start:
	// Exit system call 
	// (65 as return value)
	mov x8, 0x5d
	mov x0, 0x41
	svc 0

.section .data

