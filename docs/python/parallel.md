

Mul

HOW TO DISTRUBUTE

|         | Sequential execution      | Concurrency | Parallel     |
|---------|---------------------------|-------------|--------------|
| 1 Core  | `____----`                | `_-_-_-_-`  | Not possible |
| 2 Cores | Same, but 2nd core unused | `====`      | `====`       | 


WHO CONTROL IT


- Coroutines
  - `asyncio`: Great for IO intensive aplications
- Threading: (`threading`) Inside the same process, but swithing is controled by OS
- Multiprocess (`multiprocessing`):



https://superfastpython.com/learning-paths/