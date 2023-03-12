# IPC in C



#### Shared memory
- Shared memory segment
- Mutex
- Futex (Fast user-space locking)
- Semaphore


#### Message passing
- Socket:
  - Unix domain socket:
    - `socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)`: connection based. Send consecutive bytes.
    - `socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)`: connection-less. Send independented datagrams.
  - Internet socket:
    - `socket.socket(socket.AF_INET, socket.SOCK_STREAM)`: Realiable (Uses TCP).
    - `socket.socket(socket.AF_INET, socket.SOCK_DGRAM)`: Not realiable (Uses UDP).
- Pipe
- Queue
  - System V message queue
  - POSIX message queue


- https://linasm.sourceforge.net/docs/syscalls/ipc.php




## System V message queue


|  # | Sys call| Params                     |Ret| Description                              |
|:--:|---------|----------------------------|---|------------------------------------------|
| 68 | MSGGET  | (key_t key, int msg_flags) |int| Creates (or connects to) a message queue |
| 69 | MSGSND  |                            |   | Send a message to the message queue      |
| 70 | MSGRCV  |                            |   | Receive messages from the message queue  |
| 71 | MSGCTL  |                            |   | Changes permissions or closes the queue  |

https://www.youtube.com/watch?v=sYHoKGTvA1w



```c
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

// 1. Get IPC Key
key_t ftok(const char *pathname, int proj_id);

// 2. Get queue idenfier
int msgget(key_t key, int msg_flags);


int msgsnd(int msqid,
	       const void *msg_ptr,
           size_t msg_sz,
           int msg_flg);

ssize_t msgrcv(int msqid,
	          void *msg_ptr,
              size_t msg_sz,
              long msg_typ,
              int msg_flg);
```





## POSIX message queue

|  #  | Sys call        | Description                                           |
|-----|-----------------|-------------------------------------------------------|
| 240 | MQ_OPEN         | Open POSIX message queue                              |
| 241 | MQ_UNLINK       | Remove a message queue                                |
| 242 | MQ_TIMEDSEND    | Send a message to a message queue                     |
| 243 | MQ_TIMEDRECEIVE | Receive a message from a message queue                |
| 244 | MQ_NOTIFY       | Register for notification when a message is available |
| 245 | MQ_GETSETATTR   | Get/set message queue attributes                      |

https://www.youtube.com/watch?v=OYqX19lPb0A




