<h1 align="center">C and C++</h1>


## The C Standard Library

|              | C                      | C++                   | Defines                                    |
|--------------|------------------------|-----------------------|--------------------------------------------|
| Input Output | `#include <stdio.h>`   |                       | `printf()`, `scanf()`, `puts()`, `gets()`  |
| Booleans     | `#include <stdbool.h>` |                       |                                            |
| Memory       | `#include <string.h>`  |                       | `memcpy()`, `memset()`                     |
| Better ints  | `#include <stdint.h>`  | `#include <cstdint>`  | `uint8_t`, `int64_t`, ...                  |


std::size_t, std::vector, std::cout


## Other libraries

- Pytorch
  - ATen (tensors on the CPU & GPU)
  - Autograd (automatic differentiation)
- TensorRT 
- OpenCV
- GStreamer
- Eigen (linear algebra)
- Ceres Solver
- OR-Tools
- SFML, SDL & OpenGL
- OpenCL
- WebAssembly
- Cython
- CUDA







## Types

- C and C++ types
  - **int**
  - **char**
  - **array** Contiguos allocated in memory
  - **enum**
- Only C++ types
  - **String**
  - **Vector** Contiguos allocated in memory
  - **Linked list**: Sparse allocated in memory
  - **Hash table**
  - **Map**


## Integers

| Data Type                      | Bytes | `signed` Range                              | `unsigned` Range                            |
|--------------------------------|-------|---------------------------------------------|---------------------------------------------|
| `char`                         |   1   | `int8_t`:  -128 to 127                      | `uint8_t`: 0 to 255                         |
| `short` == `short int`         |   2   | `int16_t`: -32,768 to 32,767                | `uint16_t`: 0 to 65,535                     |
| `int`                          |   4   | `int32_t`: -2,147,483,648 to 2,147,483,647  | `uint32_t`: 0 to 4,294,967,295              | 
| `long` == `long int`           |   8   | `int64_t`: -(2^63) to (2^63)-1              | `uint64_t`: 0 to 18,446,744,073,709,551,615 | 
| `long long` == `long long int` |   8   | `int64_t`: -(2^63) to (2^63)-1              | `uint64_t`: 0 to 18,446,744,073,709,551,615 |


## Flaoting Point

| float       | 4 |  
| double      | 8 |  
| long double | 12 |  





### Clockwise/Spiral Rule

```
     ╭─────────╮
     │  ╭─╮    │
     │  ^ │    │
char * str[10];│ str is an array of 10 pointers to chars
 ^   │    │    │
 │   ╰────╯    │
 ╰─────────────╯
```

https://c-faq.com/decl/spiral.anderson.html



### Casting


float position = static_cast<float>(inference_count)



### Sizeof

```c++
// C++ program to sizes of data types
#include <iostream>
using namespace std;
 
int main()
{
    cout << "Size of char: "      << sizeof(char)      << " byte"  << endl;  // 1 byte
    cout << "Size of short int: " << sizeof(short int) << " bytes" << endl;  // 2 bytes
    cout << "Size of int : "      << sizeof(int)       << " bytes" << endl;  // 4 bytes
    cout << "Size of long int: "  << sizeof(long int)  << " bytes" << endl;  // 8 bytes

    cout << "Size of float: "     << sizeof(float)     << " bytes" << endl;  // 4 bytes
    cout << "Size of double: "    << sizeof(double)    << " bytes" << endl;  // 8 bytes
    cout << "Size of wchar_t: "   << sizeof(wchar_t)   << " bytes" << endl;  // 4 bytes
     
    return 0;
}
```


### User defined types (`struct`, `union`, `typedef`, `class`, `enum`)

- `struct`: Allow to store different data types **sequentially** in memory
- `union`: Allow to store different data types **at the same location** in memory

```c++
 // A union of pointers that points to memory for a given tensor.
typedef union {
  int32_t* i32;
  int64_t* i64;
  float* f;
  TfLiteFloat16* f16;
  char* raw;
  const char* raw_const;
  uint8_t* uint8;
  bool* b;
  int16_t* i16;
  TfLiteComplex64* c64;
  int8_t* int8;
} TfLitePtrUnion;
```


### Struct

#### Option without typedef
```c
struct person {
   unsigned int isValid: 1;
   unsigned int age: 15;
};

struct person juan;
```

#### Option with typedef

```c
typedef struct {
   unsigned int isValid: 1;
   unsigned int age: 15;
} person;

person juan;
```







## Modifiers (`const`, `static`, `extern`, )



### `auto`

Keyword to do automatic type inference.



### `const` and `constexpr`

```c++
const     double PI1 = 3.141592653589793; // constant. May be initialized at compile time or run time.
constexpr double PI2 = 3.141592653589793; // compile-time constant. It shall be initialized at compile time. 
```



### `static`

In C++, a static variable within a function will hold its value across multiple runs of the function.

```c++
#include <iostream>
using namespace std;

void func() {
   static int num = 1;
   cout << "Value of num: " << num << "\n";
   num++;
}
int main() {
   func(); // Value of num: 1
   func(); // Value of num: 2
   func(); // Value of num: 3
   return 0;
}

```


### `extern`

### `atomic`


### `global`


### `alignas(8)`


```c++
alignas(8) const unsigned char g_model[] = {
    0x1c, 0x00, 0x00, 0x00, 0x54, 0x46, 0x4c, 0x33, 0x14, 0x00, 0x20, 0x00,
    0x1c, 0x00, 0x18, 0x00, 0x14, 0x00, 0x10, 0x00, 0x0c, 0x00, 0x00, 0x00,
    0x08, 0x00, 0x04, 0x00, 0x14, 0x00
}
```





# Tips & tricks


### Efficient loop in C

```c
int a = 10 + 1

while(--a)
{
    // in range loop of 10 iters
}
```



## References

- **C**
  -  https://en.wikibooks.org/wiki/C_Programming
- **C++**
  - [Udacity C++ nanodegree](https://www.udacity.com/course/c-plus-plus-nanodegree--nd213)
  - https://www.learncpp.com
  - Video: [C++ for fun ... ctional programmers... ??? by Harald Achitz](https://www.youtube.com/watch?v=2vJfJE4K0zg)
- **Profesor Retroman**
  - Curso 1: [Programación en C++ [2016-19]](https://www.youtube.com/playlist?list=PLmxqg54iaXrjhvQy_GbzYdvURV4sKs0CT): Programación de C++ nivel intermedio.
  - Curso 2: [C++ : Programación de Videojuegos [2019/20]](https://www.youtube.com/playlist?list=PLmxqg54iaXrhTqZxylLPo0nov0OoyJqiS): Videojuego (Motor ECS) desde 0
  - Curso 3: [C++ : Programación de Videojuegos [2020/21]](https://www.youtube.com/playlist?list=PLmxqg54iaXrjOOWpeHVsV-eE2TdeQLbLD): Inteligencia Artificial del Videojuego
- Books
  - Old C++:
    - `BOOK` **Effective C++** by Scott Meyers. (C++ 98)
  - Modern C++:
    - `BOOK` **Effective Modern C++** by Scott Meyers. (C++ 14)
    - Templates de c++
    - Cualquier charla de Scott Meyers.
- [Profesor RetroMan](https://www.youtube.com/c/ProfesorRetroMan/videos) (youtube channel)














