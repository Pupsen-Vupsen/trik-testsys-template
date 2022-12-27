#!/bin/bash

echo -n -e "\033[1;31mAre you sure to delete ALL data bases? (y/N) "
tput sgr0

read -r item
case "$item" in
   y|Y) echo -n -e "\033[1;31mAre you REALLY sure to delete ALL data bases? (y/N) "
      tput sgr0
      ;;
   n|N) echo -e "\033[32mRight choice!"
      tput sgr0
      exit 0
      ;;
   *) echo -e "\033[33mIt supposed you accidentally called this script"
      tput sgr0
      exit 0
      ;;
esac

read -r item
case "$item" in
   y|Y) echo -e "\033[5;31mStarted deleting ALL data bases"
      tput sgr0
      ;;
   n|N) echo -e "\033[32mRight choice!"
      tput sgr0
      exit 0
      ;;
   *) echo -e "\033[33mIt supposed you accidentally types \"y\" at the previos step"
      tput sgr0
      exit 0
      ;;
esac

cd ~/application/data || exit

rm submissions.mv.db
echo -e "\033[33mDeleted submissions.mv.db"

rm submit.sqlite
echo -e "\033[33mDeleted submit.sqlite"
rm submit.sqlite-shm
echo -e "\033[33mDeleted submit.sqlite-shm"
rm submit.sqlite-wal
echo -e "\033[33mDeleted submit.sqlite-wal"

rm user.sqlite
echo -e "\033[33mDeleted user.sqlite"
rm user.sqlite-shm
echo -e "\033[33mDeleted user.sqlite-shm"
rm user.sqlite-wal
echo -e "\033[33mDeleted user.sqlite-wal"

touch submit.sqlite
echo -e "\033[32mCreated submit.sqlite"
touch user.sqlite
echo -e "\033[32mCreated user.sqlite"
tput sgr0
