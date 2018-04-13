#!/usr/bin/env sh
set -e
pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    exit_handler
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

exit_handler() {
  touch /var/run/aws/status.done
}

# setup handlers
trap 'kill ${!}; term_handler' SIGTERM

# run application
$@ &
pid="$!"

# wait app
wait "$pid"
exit_handler
