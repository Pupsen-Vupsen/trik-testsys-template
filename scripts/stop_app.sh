#!/bin/bash

echo -n -e "\033[1;31mAre you sure to stop application? (y/N) "
tput sgr0

read item
case "$item" in
   y|Y) echo -n -e "\033[1;31mAre you REALLY want to STOP application? (y/N) "
      tput sgr0
      ;;
   n|N) echo -e "\033[32mOK..."
      tput sgr0
      exit 0
      ;;
   *) echo -e "\033[32mYou're lucky!"
      tput sgr0
      exit 0
      ;;
esac

read item
case "$item" in
   y|Y) echo -e "\033[5;31mStarted stoping application"
      tput sgr0
      ;;
   n|N) echo -e "\033[032mSay thanks to second try"
      tput sgr0
      exit 0
      ;;
   *) echo -e "\033[032mWhy are you g*y?"
      tput sgr0
      exit 0
      ;;
esac

docker-compose down
