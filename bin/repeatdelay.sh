#!/bin/sh
# epilepsy warning
# usage: ./repeatdelay <infile> <outfile>
VIDEO_SIZE=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$1")
FR_FRACTION=$(ffprobe -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=r_frame_rate "$1")
FRAME_RATE=$(python3 -c "print($FR_FRACTION)")
DOUBLE_FRAME_RATE=$(python3 -c "print($FRAME_RATE * 2)")
PIX_FMT="yuv420p" # or rgb24

{

  ffmpeg -i "$1" -f rawvideo -pixel_format $PIX_FMT -framerate $FRAME_RATE - &
  ffmpeg -i "$1" -f rawvideo -pixel_format $PIX_FMT  -framerate $FRAME_RATE -
} | ffmpeg -y -f rawvideo -video_size $VIDEO_SIZE -pixel_format $PIX_FMT -framerate $DOUBLE_FRAME_RATE -i - "$2"
