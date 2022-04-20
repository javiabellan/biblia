# Profiling


## The lazy way: `time`

in python:
```python
import time

start = time.time()
muy_fun() # Long code here
print(time.time() - start)
```

in jupyter:

```python
%time muy_fun()
%timeit -r 2 -n 5 muy_fun() # -r: number of runs, -n: number of loops
```

On the shell: `$ time some_command`
- **`real`**: Real time. Other programs or internet connection affect.
- **`user`**: User time. Amount of time spent in the CPU running user code
- **`sys`**: Syestem time. Amount of time spent in the CPU running kernel code.



## CPU profiler

There are two main types of CPU profilers:
- **Tracing profilers** keep a record of every function call your program makes.
  - No son muy fiables porque acompañan siempre al programa y esto puede interferir en el rendimiento
- **Sampling profilers** probe your program periodically (commonly every millisecond) and record the program’s stack.

[Here](https://jvns.ca/blog/2017/12/17/how-do-ruby---python-profilers-work-/) is a good intro article if you want more detail on this topic.



## CPU line profilers

- [line_profiler](https://github.com/pyutils/line_profiler): `pip install line-profiler`
- [pprofile](https://github.com/vpelletier/pprofile): `pacman -S python-pprofile`

```python
import time

@profile
def my_fun():
  time.sleep(2)
  for i in range(3):
    print("print")
    time.sleep(1)
my_fun()
```

```bash
$ kernprof -l -v program_with_my_fun.py

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
     3                                           @profile
     4                                           def my_fun():
     5         1    2002083.0 2002083.0     40.0    time.sleep(2)
     6         4         36.0      9.0      0.0   for i in range(3):
     7         3        188.0     62.7      0.0     print("print")
     8         3    3002333.0 1000777.7     60.0      time.sleep(1)
```

In jupyter

```python
%load_ext line_profiler

%lprun -f func_to_profile func_to_profile(params)
```



## Memory profiler

Install with `pip install memory-profiler` or `pacamn -S python-memory-profiler`

```python
@profile
def my_func():
    a = [1] * (10 ** 6)
    b = [2] * (2 * 10 ** 7)
    del b
    return a

my_func()
```


```bash
$ python -m memory_profiler mem.py

Line #    Mem usage    Increment   Line Contents
================================================
     1   38.637 MiB   38.637 MiB   @profile
     2                             def my_func():
     3   46.090 MiB    7.453 MiB       a = [1] * (10 ** 6)
     4  198.715 MiB  152.625 MiB       b = [2] * (2 * 10 ** 7)
     5   46.270 MiB    0.000 MiB       del b
     6   46.270 MiB    0.000 MiB       return a
```
