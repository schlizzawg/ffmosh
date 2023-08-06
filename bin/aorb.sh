#!/bin/sh

{ ffmpeg -re -i "$1" -f mpegts -c:v mpeg1video - &
  ffmpeg -re -i "$2" -f mpegts -c:v mpeg1video -
} | ffmpeg -i - out.mp4
