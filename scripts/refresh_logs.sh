#!/bin/bash

echo -n -e "\033[31mAre you sure to refresh logs? (y/N) "
tput sgr0

read item
case "$item" in
   y|Y) echo -n -e "\033[31mAre you REALLY want to refresh ALL logs? (y/N) "
      tput sgr0
      ;;
   n|N) echo -e "\033[32mOK..."
      tput sgr0
      exit 0
      ;;
   *) echo -e "\033[32mLet's say it means \"No\""
      tput sgr0
      exit 0
      ;;
esac

read item
case "$item" in
   y|Y) echo -e "\033[5;31mStarting refreshing logs"
      tput sgr0
      ;;
   n|N) echo -e "\033[32mSay thanks to second chance"
      tput sgr0
      exit 0
      ;;
   *) echo -e "\033[32mYou're lucky one!"
      tput sgr0
      exit 0
      ;;
esac

cd ~/application/logs

rm api.txt
echo -e "\033[31mRemoved api.txt"
rm bot.txt
echo -e "Removed bot.txt"
rm server.log
echo -e "Removed server.log"

touch api.txt
echo -e "\033[32mCreated api.txt"
touch bot.txt
echo -e "\033[32mCreated bot.txt"
touch server.log
echo -e "\033[32mCreated server.log"
tput sgr0
