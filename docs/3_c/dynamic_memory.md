

## Memoria de un programa

- Estática: Tamaño fijo durante toda la ejecución del programa
  - text: Código (lógica) del programa
  - data: Varibles globales inicializadas
  - bss: Varibles globales no inicializadas
- Automática (stack): Llamadas a funciones
- Dinámica (heap): Memoria explicitamente alojada y desalojada
  - `malloc`, `free` in **C**
  - `new`, `delete` in **C++**

![memory](https://i.stack.imgur.com/wn0oN.jpg)


## Allocate memory: `malloc`

Aloja memoria del tamaño indicado y devuleve un puntero.

```c
int *p = malloc(n * sizeof(int));
```

Si no conces el tipo del puntero, puedes poner:

```c
int *p;
p = malloc(n * sizeof(*p));
```

Si no se pudo alojar dicha memoria, devuelve un puntero NULL, así que se debe controlarlo.

```c
if (p == NULL) {
  fprintf(stderr, "malloc failed\n");
  return(-1);
}
```

## Desalojar memoria: `free`

Cuando hallas acabado de usar esa memoria, la puedes liberar.

```c
free(p)
```



## `malloc` under the hood: `brk` or `mmap` syscall
- If i demand **few** memory probably the syscall will be `brk()` and memory is on the heap
- If i demand **big** memory probably the syscall will be `mmap()` and memory on mmap space


## Reference

- Jacob Sorber
  - [How processes get more memory. (mmap, brk)](https://www.youtube.com/watch?v=XV5sRaSVtXQ)
- Low level learning
  - [The Origins of Process Memory](https://www.youtube.com/watch?v=c7xf5dvUb_Q)






