## Inter Process Comunication (IPC)

- Shared files
- Shared memory (with semaphores)
- Pipes
  - unnamed pipes `|`
  - named pipes `mkfifo my_pipe` (aka FIFO)
- Message queues
- Sockets
  - Unix domain sockets
  - TCP/IP sockets
  - https://www.youtube.com/watch?v=8TGV4zcd9k4
- Signals



## Practical IPC with python

Unix domain socket < gRPC < HTTP


|            | Unix domain socket | gRPC | HTTP |

address        `unix://`         


data is exchanged via a Unix domain socket (unix:// address) instead of a TCP socket


https://www.mpi-hd.mpg.de/personalhomes/fwerner/research/2021/09/grpc-for-ipc/