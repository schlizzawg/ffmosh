#!/bin/sh
# epilepsy warning
# usage: ./repeatdelay <infile> <outfile>
FR_FRACTION=$(ffprobe -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=r_frame_rate "$1")
FRAME_RATE=$(python3 -c "print($FR_FRACTION)")
DOUBLE_FRAME_RATE=$(python3 -c "print($FRAME_RATE * 2)")

{
  ffmpeg -i "$1" -f mpegts - &
  ffmpeg -i "$1" -f mpegts -
} | ffmpeg -y -err_detect ignore_err -f mpegts -i - "$2"
