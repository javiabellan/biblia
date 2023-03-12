# Syscalls

[linux system calls table](https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md)




## Syscalls x86 32bits

1. Specify the syscall number into `EAX`.
2. Specify the syscall paramenters into `EBX`, `ECX`, `EDX`, `ESI`, `EDI`, `EBP`
3. Invoque interruption: `INT 0x80`

| Syscall | EAX | EBX Param 1  | ECX Param 2  | EDX Param 3  | Description                                                |
|---------|-----|--------------|--------------|--------------|------------------------------------------------------------|
| exit    |  1  | int status   |              |              | Exit the program with some status code.                    |
| write   |  4  | int FileDesc | char* buffer | size_t count | Write n bytes (count) from the buffer to a file descriptor |

[Reference](https://secureideas.com/blog/2021/05/linux-x86-assembly-how-to-build-a-hello-world-program-in-nasm.html)


## Syscalls x86 64bits

1. Specify the syscall number into `RAX`.
2. Specify the syscall paramenters into `RBX`, `RCX`, `RDX`, `RSI`, `RDI`, `RBP`
3. Invoque the syscall: `SYSCALL`
