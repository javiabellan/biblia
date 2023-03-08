

https://cloudcity.io/blog/2019/02/27/things-i-wish-they-told-me-about-multiprocessing-in-python/
https://cloudcity.io/blog/2019/05/14/five-python-multiprocessing-tips-pycon-2019-video/

# IPC in Python

**I**nter **P**rocess **C**ommunication (IPC) is very improtant because process are independent (do not share memory and run in parallel).

## Index

#### Shared memory -> the BAD approach
- Shared memory:
  - `multiprocessing.Value`
  - `multiprocessing.Array`
  - `multiprocessing.shared_memory`: [Stackoverflow answer](https://stackoverflow.com/questions/14124588/shared-memory-in-multiprocessing)

#### Message passing -> the GOOD approach
- Socket:
  - Unix domain socket:
    - `socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)`: connection based. Send consecutive bytes.
    - `socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)`: connection-less. Send independented datagrams.
    - `multiprocessing.connection.Listener('AF_UNIX')`
  - Internet socket:
    - `socket.socket(socket.AF_INET, socket.SOCK_STREAM)`: Realiable (Uses TCP).
    - `socket.socket(socket.AF_INET, socket.SOCK_DGRAM)`: Not realiable (Uses UDP).
    - `multiprocessing.connection.Listener('AF_INET')`
- Pipe:
  - `multiprocessing.Pipe`
  - `multiprocessing.connection.Listener('AF_PIPE')`
- Queue:
  - `multiprocessing.Queue`

> External libraries
> - `Flask`: Tradition web server with
> - `zeromq`: https://zeromq.org/

#### Remote Procedure call (RPC)
Call fuctions/methods from outside.
- `RPyC`
- `XML-RPC`: https://docs.python.org/3/library/xmlrpc.client.html
- `gRPC`: HTTP2 + Google protobuffers

---


## Sockets

needs pickle to stringfy obj and send it

      - Client: `socket.send( pickle.dumps(variable) )`
      - Server: `data = pickle.loads( conn.recv(4096) )`

### Server (multiple connections)


```python
import socket
import threading


# Threaded function
def handle_connection(conn):
   while True:
       data = conn.recv(1001) # Data is received from the conn
       if not data:
           print('No connection, Bye')
          
           # Releasing lock on exit
           break

       # DO SOMETHING WITH data

       # conn.send(data) # Send data back

   conn.close()
```


```python
def main():

    # Create socket and listen to it. 
    sock = socket.socket(...) # (socket.AF_INET, socket.SOCK_STREAM)
    sock.bind((HOST, PORT))
    sock.listen(5)

    # Wait for connections (BLOCKING)
    while True:
        conn, addr = sock.accept() # <-- blocks here.
        print('Connected to :', addr[0], ':', addr[1])
        client_process = Process(target=handle_connection, args=(conn))
        client_process.start()
    sock.close()
```


```python
def main():

	# Create socket and listen to it. 
    sock = socket.socket(...) # (socket.AF_INET, socket.SOCK_STREAM)
    sock.bind((HOST, PORT))
	socket.settimeout(0.1)
	socket.listen(1)

    # Wait for connections (NON BLOCKING)
	while True:
	    try:
	        conn, addr = socket.accept()
	        print('Connected to :', addr[0], ':', addr[1])
	       	client_process = Process(target=handle_connection, args=(conn))
        	client_process.start()
	    except socket.timeout:
	        continue
	sock.close()
```





## Better Sockets with `Listener` and `Client`


### Server (max 1 connection)
```python
from multiprocessing.connection import Listener

address = ('localhost', 6000) # family is deduced to be 'AF_INET'
listener = Listener(address, authkey=b'secret password')
conn = listener.accept()  # <---  This blocks!
print 'connection accepted from', listener.last_accepted
while True:
    msg = conn.recv()  # <---  This blocks!
    # do something with msg
    if msg == 'close':
        conn.close()
        break
listener.close()
```

### Server (multiple connections)

```python
from multiprocessing.connection import Listener

listener = Listener(('localhost', 6000), authkey=b'secret password')
running = True
while running:
    conn = listener.accept()  # <---  This blocks!
    print('connection accepted from', listener.last_accepted)
    while True:
        msg = conn.recv()  # <---  This blocks!
        print(msg)
        if msg == 'close connection':
            conn.close()
            break
        if msg == 'close server':
            conn.close()
            running = False
            break
listener.close()
```


### Client

```python
from multiprocessing.connection import Client

address = ('localhost', 6000)
conn = Client(address, authkey=b'secret password')
conn.send('close')
# can also send arbitrary objects:
# conn.send(['a', 2.5, None, int, sum])
conn.close()
```






## Queues: `multiprocessing.Queue`

> Don’t Share Resources, Pass Messages

At first thought, it might seem like a good idea to have some sort of shared data structures that would be protected by locks. When there is only *one* shared structure, you can easily run into issues with blocking and contention. As such structures proliferate, however, the complexity and unexpected interactions multiply, potentially leading to deadlocks, and very likely leading to code that is difficult to maintain and test. The better option is to pass **messages** using `multiprocessing.Queue` objects. Queues should be used to pass all data between subprocesses. This leads to designs that “chunkify” the data into messages to be passed and handled, so that subprocesses can be more isolated and functional/task oriented. The Python `Queue` class is implemented on unix-like systems as a PIPE - where data that gets sent to the queue is serialized using the Python standard library `pickle` module. Queues are usually initialized by the main process and passed to the subprocess as part of their initialization.

Source: https://cloudcity.io/blog/2019/02/27/things-i-wish-they-told-me-about-multiprocessing-in-python/

```python
from multiprocessing import Process, Queue

def f(q):
    q.put([42, None, 'hello'])

if __name__ == '__main__':
    q = Queue()
    p = Process(target=f, args=(q,))
    p.start()
    print(q.get())    # prints "[42, None, 'hello']"
    p.join()
```


## Pipes:

```python
from multiprocessing import Process, Pipe

def f(conn):
    conn.send([42, None, 'hello'])
    conn.close()

if __name__ == '__main__':
    parent_conn, child_conn = Pipe()
    p = Process(target=f, args=(child_conn,))
    p.start()
    print(parent_conn.recv())   # prints "[42, None, 'hello']"
    p.join()
```


### Shared memory: `multiprocessing.Value` or `multiprocessing.Array`

```python
from multiprocessing import Process, Value, Array

def f(n, a):
    n.value = 3.1415927
    for i in range(len(a)):
        a[i] = -a[i]

if __name__ == '__main__':
    num = Value('d', 0.0)
    arr = Array('i', range(10))

    p = Process(target=f, args=(num, arr))
    p.start()
    p.join()

    print(num.value)
    print(arr[:])
```






# Example of full code


```python
############################
import socket, pickle

class VectorDB_client():

    def __init__(self, ip, port):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.connect((ip, port))

    def send_py_obj(self, obj):
        self.sock.send( pickle.dumps(obj) )

##########################

# Threaded function
# https://stackoverflow.com/questions/2915160/how-do-i-abort-a-socket-recv-from-another-thread-in-python
def handle_connection(conn):
    while True:

        try:
            print(db)

            data = pickle.loads( conn.recv(4096) ) # <--- blocks
            print(data)

            if not data:
                print('No connection, Bye')
                break # Releasing lock on exit

        except socket.timeout: 
            # If it was a timeout, we want to continue with recv
            continue
        except KeyboardInterrupt:
            break

        # DO SOMETHING WITH data
        # conn.send(data) # Send data back
        #socket.send( pickle.dumps(variable) )

    print(f"Closing VectorDB connection")
    conn.close()


if __name__ == '__main__':

    ############################### Parse command-line named arguments
    parser=argparse.ArgumentParser()
    parser.add_argument("--host", help="Service host")
    parser.add_argument("--port", help="Service port", type=int)
    args=parser.parse_args()

    ############################### Create socket server

    # Create socket and listen to it.
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind((args.host, args.port)) # INET socket needs ip and port
    #sock.bind("/tmp/socket_test.s")  # UNIX socket needs a socket file
    sock.settimeout(1) # 1 sec max for sock.accept()
    sock.listen(1)
    print(f"VectorDB is listening on {args.host}:{args.port}")

    # Wait for connections (NON BLOCKING)
    while True:
        try:
            conn, (client_ip, client_port) = sock.accept() # <--- blocks for N seconds
            print(f"Connected to client: {client_ip}:{client_port}")
            client_thread = threading.Thread(target=handle_connection, args=(conn,)) # <-- Comma is needed
            client_thread.start()
        except socket.timeout:
            #print("Listening again...")
            continue
        except KeyboardInterrupt:
            break

    print(f"Closing VectorDB server {args.host}:{args.port}")
    sock.shutdown(socket.SHUT_RDWR) # closes the underlying connections
    sock.close()

# Do signals propagate on subthreads? -> NO (YES if daemon)
#
# Python signal handlers are always executed in the main Python thread of the main interpreter,
# even if the signal was received in another thread.
#
# After you send SIGINT with ^C, you will see that the main thread is killed
# (no more 'Parent parenting' logs)and the child thread continues to run.

# Do signals propagate on subprocess? -> YES
```
