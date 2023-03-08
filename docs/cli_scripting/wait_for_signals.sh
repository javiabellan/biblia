#!/usr/bin/env bash

catch_kill() {
  echo "Caught SIGKILL signal!"
  kill -KILL "$pid" 2>/dev/null
}

catch_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$pid" 2>/dev/null
}

catch_quit() {
  echo "Caught SIGTERM signal!"
  kill -QUIT "$pid" 2>/dev/null
}

catch_ctrlc() {
  echo "Caught ctrl+c!"
  kill -KILL "$pid" 2>/dev/null
}

trap catch_term SIGTERM
trap catch_kill SIGKILL
trap catch_quit SIGQUIT
trap catch_ctrlc INT

echo "Script is running! waiting for signals."

pid=$$

sleep infinity