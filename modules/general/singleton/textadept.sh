#!/usr/bin/env bash
# Execute Textadept in a single instance.
# If an instance is running, then create new file with passed files paths to open.
# To open Textadept in separate window use: `textadept -f`.
#
# When you open files from other program (such as file browser) - those files
# will be opened only in "main" instance (not forced ones).
#
# $@ - files to open by Textadept

APP=textadept
APP_CMD=$APP
LOCK_PATH=$HOME/.app-locks/$APP.lock
TA_FILES_DIR=~/.textadept/.files_to_open

printf "Starting singleton app: $APP\nUsing command: $APP_CMD\n"
mkdir -p $TA_FILES_DIR

IFS=';' read -ra PID_LIST <<< "$(pidof -S ';' $APP)"

if [ -n "$PID_LIST" ]; then
  APP_PID=${PID_LIST[-1]}
  FILES_TO_OPEN=""

  for var in "$@"
  do
    FILES_TO_OPEN=$FILES_TO_OPEN$(realpath "$var")"\n"
  done

  if [ -n "$FILES_TO_OPEN" ] && [ "$FILES_TO_OPEN" != "\n" ]; then
    printf "Adding files to open by Textadept\n"
    echo -e $FILES_TO_OPEN > $TA_FILES_DIR/$(date +"%s")_files.txt
  fi

  flock --nonblock $LOCK_PATH $APP_CMD
  xdotool search --pid $APP_PID | xargs -I % i3-msg '[id="%"] focus'
else
  flock --nonblock $LOCK_PATH $APP_CMD
fi
