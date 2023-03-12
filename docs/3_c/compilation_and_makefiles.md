# Compilation

```
_COMPILER_  _PROGRAM_  _GDB_ __OUTPUT__
   gcc      program.c   -g   -o program

```


# Compilation process

- By defoult `-S` generates 64bits assembly using AT&T syntax.
- And we want intel syntax, so `-masm=intel`
- And we want 32 bits, so `-m32`


```


                                  
                                  gcc program.c   -o program.o
                                  gcc program.cpp -o program.o
          _________________________________________________________________________________
         /                                                                                 \
        /                                       ______                                      \
       /                                       /      |                                      \
      /   gcc program.c   -S -o program.s     | AT&T  |                                       \
  ___/__  g++ program.cpp -S -o program.s     |  x86  |                                      __V__
 /      | ----------------------------------> | asemb | objdump -S program.o                /     |
| C/C++ |                                     |_______| <--------------------------------  | Obj  | gcc program.o -m32 -o program
| file  |                                       ______                                     | file | ld program.o -m elf_i386 -o program
| .c    | gcc program.c   -S -masm=intel -m32  /      | nasm -f elf program.s  (for linux) |  .o  |------------------------------------
| .cpp  | g++ program.cpp -S -masm=intel -m32 | Intel | nasm -f exe program.s  (for win)   |______|
|_______| ----------------------------------> |  X86  | --------------------------------->
                                              | asemb | 
                                              |  .s   | objdump -S -M intel program.o
                                              |_______| <---------------------------------

 .c/.cpp  --------------COMPILER-------------->  .s  ------------ASSEMBLER---------------->  .o   --------------LINKER---------------> EXEC  

```

# Makefile

Run `make`. If the build seems slow, try `make -j4` to use 4 threads.