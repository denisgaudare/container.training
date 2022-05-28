#!/bin/sh
set -e
case "$1" in
once)
  python ./index.py
  for YAML in *.yml; do
    python ./markmaker.py $YAML > $YAML.html || { 
      rm $YAML.html
      break
    }
  done
  if [ -n "$SLIDECHECKER" ]; then
    for YAML in *.yml; do
      python ./appendcheck.py $YAML.html
    done
  fi
  rm -f /tmp/slides.tgz
  tar --exclude-from=./tarignore.txt -cvzf /tmp/slides.tgz .
  mv /tmp/slides.tgz .
  echo "Created slides.tgz archive."
  ;;

forever)
  set +e
  # check if entr is installed
  if ! command -v entr >/dev/null; then
    echo >&2 "First install 'entr' with apt, brew, etc."
    exit
  fi
  
  # There is a weird bug in entr, at least on MacOS,
  # where it doesn't restore the terminal to a clean
  # state when exitting. So let's try to work around
  # it with stty.
  STTY=$(stty -g)
  while true; do
    find . | entr -d $0 once
    STATUS=$?
    case $STATUS in
    2) echo "Directory has changed. Restarting.";;
    130) echo "SIGINT or q pressed. Exiting."; break;;
    *) echo "Weird exit code: $STATUS. Retrying in 1 second."; sleep 1;;
    esac
  done
  stty $STTY
  ;;

*)
  echo "$0 <once|forever>"
  ;;
esac
