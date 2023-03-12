


Process virtual memory


```
                     VIRTUAL MEMORY OF A PROCESS
 0x00000000  ╔══════════════════════════════════════════╗
             ║                                          ║
             ║                                          ║
 0x08048000  ╟──────────────────────────────────────────╢
             ║                 TEXT                     ║\
             ║             (Binary code)                ║ | 
             ╟──────────────────────────────────────────╢ | Initiali filled 
             ║                 DATA                     ║ | with content of
             ║            Initialized data              ║ | my_program.out
             ║      (global and static variables)       ║/
             ╟──────────────────────────────────────────╢
             ║                  BSS                     ║\
             ║           Uninitialized data             ║ |
             ║     (global and static variables)        ║ | Initiali filled
             ╟──────────────────────────────────────────╢ | with zeros
             ║                 HEAP                     ║ |
             ║             Dynamic memory               ║ |
             ║            malloc/free in C              ║ |
             ║            new/delete in C++             ║/
             ╟────────────────────┬─────────────────────╢-> brk (program break)
             ║                    ▼                     ║
             ║                                          ║
             ║                   ...                    ║
             ║                                          ║
             ║                    ▲                     ║
             ╟────────────────────┴─────────────────────╢
             ║             MEMORY MAPPING               ║\
             ║ - Included shared libraries (printf...)  ║ | For #include libraries 
             ║ - Shared file for IPC mmap(SHARED, FILE) ║ | Initiali filled
             ║ - Shared mem. for IPC mmap(SHARED, ANON) ║ | Initiali filled
             ║ - Read file fast     mmap(PRIVATE, FILE) ║ | with content of
             ║ - Subthreads stack                       ║ | libc.so, ...
             ╟────────────────────┬─────────────────────╢/
             ║                    ▼                     ║
             ║                                          ║
             ║                   ...                    ║
             ║                                          ║
             ║                    ▲                     ║
             ╟────────────────────┴─────────────────────╢\
             ║           Main thread STACK              ║ | Initiali filled
             ║                                          ║ | with zeros
        3GB  ╠══════════════════════════════════════════╣/
             ║               KERNEL SPACE               ║
             ║      User can not read/write here        ║
        4GB  ╚══════════════════════════════════════════╝
```


### A Process owns:
- PID: Process Identifier
- PPID: Parent PID
- UID: User Identifier (the person who initiated)
- GID: Group identifier (the person who initiated)
- TEXT segment (binary code instructions)
- DATA segment (static and global data)
  - Global variables: `int myglobalint = 5;`
  - Static variables: `static char* mystaticstr = "hello";`
- BSS segment (uninitialized data)
  - `static char* my_uninitialized_str`
- HEAP segment (Dynamically-allocated memory)
  - `malloc`/`free` in C
  - `new`/`delete` in C++
- MEMORY MAPPING segment
  - FILE OR ANONYMOUS
    - FILE mappings (code of included libraries, eg `printf`)
    - ANONYMOUS mappping
  - SHARED vs PRIVATE
- MAIN STACK segment
  - Space for the stack **of the main thread**
- Page table (maps virtual adresses into physical addrs)
- Open files descriptors (every open file has an offset)
- Signal handlers
- Current working directory
- Enviroment variables (`$ env A=val ./program`)
- Command line arguments (see them in `/proc/PID/cmdline`)
- Main Thread --> ALWAYS
- Sub Threads --> OPTIONAL


### A Thread owns:
- Thread ID
- Stack (called functions, local variables, return addresses)
  - **Stack space for a new thread is created by the parent thread with mmap(). So they're in the "memory map segment"**
- Saved Registers
  - General purpose registers
  - PC (program counter)
  - SP (stack pointer)
- Priority (scheduling information)


### thread-thread switching


Thread take less time to create

### process-process switching

Much slower than thread-thread switching


### Refenrences

- [Jacob Sorber: How processes get more memory. (mmap, brk)](https://www.youtube.com/watch?v=XV5sRaSVtXQ)
- [Jacob Sorber: How to Map Files into Memory in C](https://www.youtube.com/watch?v=m7E9piHcfr4)
- [Jacob Sorber: Virtual Memory](https://www.youtube.com/watch?v=Aw0YAUdQp1c)
- [Jacob Sorber: The Heap](https://www.youtube.com/watch?v=GIWeQ2I67rk)
- [ByteByteGo: Process vs Thread ](https://www.youtube.com/watch?v=4rLW7zg21gI)
- [Chris Kanich: Process vs Thread](https://www.youtube.com/watch?v=85T_ZaT8EUI)
- [Chris Kanich: when to use processes, when to use threads](https://www.youtube.com/watch?v=syecJXuC80I)
- [Chris Kanich: understanding mmap](https://www.youtube.com/watch?v=8hVLcyBkSXY)
- [Julia Evans: Bit size Linux]()
https://stackoverflow.com/questions/44858528/where-are-the-stacks-for-the-other-threads-located-in-a-process-virtual-address

https://people.cs.rutgers.edu/~pxk/416/notes/05-threads.html



