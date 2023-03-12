// AARCH64 Assembly Tutorial (https://www.youtube.com/watch?v=8NdrdxkBP3U)
//
// COMPILE
//   aarch64-linux-gnu-as 02_HelloWorld.asm -o 02_HelloWorld.out
//
// LINK into an executable
//   aarch64-linux-gnu-gcc 02_HelloWorld.out -o 02_HelloWorld.elf -nostdlib -static
//
// EXECUTE
//   qemu-aarch64 ./02_HelloWorld.elf


.global _start

.section .text
_start:
	// Write system call
	mov x8, 64
	mov x0, 1
	ldr x1, =message
	mov x2, 13   // Lenght of the string
	svc 0        // System call

	// Exit system call 
	// (65 as return value)
	mov x8, 0x5d
	mov x0, 0x41
	svc 0

.section .data
message:
	.ascii "Hello, world\n" // This adds null byte to the end
