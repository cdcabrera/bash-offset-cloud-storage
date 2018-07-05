#!/usr/bin/env bash
#
#
# Count existing scans
#
countScans()
{
  local COUNT=2

  printf "  ${GREEN}${COUNT} existing scans...${NOCOLOR}\n\n"
}
#
# Print existing scans
#
printScans()
{
  echo "Scans:"
  echo "    (1) lorem"
  echo "    (2) ipsum"
  echo "  Choose a scan to delete:"
}
#
# Use description
#
usage()
{
cat <<- EEOOFF

Offset Cloud Storage - Offset cloud storage by
ignoring directories.

  To exit type and enter "q", or simply ctrl-c

  GitHub: https://bit.ly/2KB0pJx

EEOOFF
}
#
# main()
#
{
  RED="\e[31m"
  GREEN="\e[32m"
  NOCOLOR="\e[39m"
  STEPS=1
  ADD_DELETE=""
  DELETE=""
  ID=""
  STORAGE=""
  TIMER=""
  PATHS=""

  usage

  countScans

  exec < /dev/tty

  while true; do

    case "$STEPS" in
      1) read -p "  (1) Add, or (2) Delete an existing scan? Choose: " ADD_DELETE;;
      2) read -p "  $(printScans) " DELETE;;
      3) read -p "  Enter an identifier for the scan: " ID;;
      4) read -p "  Enter the directory path of your cloud storage: " STORAGE;;
      5) read -p "  How often, in minutes, should the script check for symlinks? (enter a number/int): " TIMER;;
      6) read -p "  Enter the directory path(s) to symlink (space separate multiple entries): " PATHS;;
    esac

    if [ "$ADD_DELETE" = "q" ] || [ "$DELETE" = "q" ] || [ "$ID" = "q" ] || [ "$STORAGE" = "q" ] || [ "$TIMER" = "q" ] || [ "$PATHS" = "q" ]; then
      exit 1;
    fi



    if [ $ADD_DELETE = 2 ]; then
      STEPS=2
    fi

    if [ $ADD_DELETE = 1 ]; then
      STEPS=3
    fi

    if [ ! -z "$DELETE" ]; then
      printf "\n  ${RED}Scan \"${DELETE}\" deleted.${NOCOLOR}\n\n"
      # TODO: check to see if any remaining scans if not could jump right into adding a new one
      STEPS=1
      DELETE=""
    fi

    if [ ! -z "$ID" ]; then
      STEPS=4
    fi

    if [ ! -z "$STORAGE" ]; then
      STEPS=5
    fi

    if [ "$TIMER" -eq "$TIMER" ] 2>/dev/null; then
      STEPS=6
    fi

    if [ ! -z "$PATHS" ]; then
      exit 0;
    fi

  done
}
