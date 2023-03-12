# Pointers

```c++
////////////////////////////// CREATING THE POINTERS
Object* my_object_pointer   = &my_object   // Create pointer by reading the memory adress of exiting object
Object* my_object_pointer   = ObjectPtr(); // Create pointer by creating object

int* int_pointer            = NULL;       // Create null pointer (C)
Object* my_object_pointer   = nullptr;    // Create null pointer (C++)


////////////////////////////// USING THE POINTERS
my_object.do_somthing()
my_object->do_somthing()

int_pointer++  // POINTER = POINTER + 4 bytes // sizeof(int)
```

## Pointer arithmetic

https://www.youtube.com/watch?v=q24-QTbKQS8



## Double pointer

int16_t** audio_samples


## Arrays multidimensionales)



```c
double* array = malloc(M*N*sizeof(*array)); // Array (puntero)

int (*array4)[NCOLUMNS] = malloc(nrows * sizeof(*array4)); // Punteros a arrays

int (*array5)[NROWS][NCOLUMNS] = malloc(sizeof(*array));  // Punteros a arrays
```



## Referencia

* https://en.wikibooks.org/wiki/C_Programming/Common_practices#Dynamic_multidimensional_arrays
* http://c-faq.com/aryptr/dynmuldimary.html




## `const` in pointers

There ar 2 things that can be const:

- the pointer itself
- The thing the pointer points to.

```c++
char greeting[] = "Hello";

char* p = greeting;               // non-const pointer,  non-const data
const char* p = greeting;         // non-const pointer,  const data
char* const p = greeting;         // const pointer,  non-const data
const char* const p = greeting;   // const pointer,  const data
const char* const authorName = "Scott Meyers";
```

                                                        | ptr = &var2; | *ptr = 4; |
|-------------------------|-----------------------------|--------------|-----------|
| `int * ptr`             | pointer to int              |      ✅      |     ✅     |
| `int const * ptr`       | pointer to const int        |      ✅      |     ❌     |
| `int * const ptr`       | const pointer to int        |      ❌      |     ✅     |
| `int const * const ptr` | const pointer to const int  |      ❌      |     ❌     |

https://stackoverflow.com/questions/1143262/what-is-the-difference-between-const-int-const-int-const-and-int-const

