# Process

- Every process has a parent
- When you close/kill the parent pocess you kill all the chol processes
- `disown -a` Idepedizar tareas hijas (que probablemente estan en segundo plano) 


```bash
CTRL + l   # Clean terminal
CTRL + c   # Interrumpir programa (SIGINT)
CTRL + \   # Salir programa (SIGQUIT)
CTRL + z   # Pausar programa que se puede reunaudar (SIGSTOP)
jobs        # See all the jobs that are running or suspended.
my_command &  # When you append " &"  it becomes a "background job".
my_command_2 && my_command_2 # Do my_command_2 only if my_command_2 was success
fg          # Bring the job to the foreground.
bg          # Send the job to the background.
stop {PID} or Ctrl + z          # Suspend the job.
kill {PID} or Ctrl + c          # Terminate the job.
```