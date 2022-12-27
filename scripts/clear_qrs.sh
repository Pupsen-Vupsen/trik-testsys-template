#!/bin/bash

echo -n -e "\033[31mAre you sure do delete all saved submissions? (y/N) "
tput sgr0

read -r item
case "$item" in
   y|Y) echo -e "\033[5;31mStarted deleting .qrs!"
      tput sgr0
      ;;
   n|N) echo -e "\033[32mYou're lucky this time"
      tput sgr0
      exit 0
      ;;
   *) echo -e "\033[33mIt supposed you accidentally called this script"
      tput sgr0
      exit 0
      ;;
esac

cd ~/application/data/tasks || exit
echo -e "\033[033mDeleted files:"
find . -name "*.qrs"
tput sgr0
rm ./*/*.qrs
