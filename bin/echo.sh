#!/bin/sh
# epilepsy warning
# usage: ./repeatdelay <infile> <outfile>
VIDEO_SIZE=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$1")
FR_FRACTION=$(ffprobe -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=r_frame_rate "$1")
FRAME_RATE=$(python3 -c "print($FR_FRACTION)")
PIX_FMT="yuv420p" # or rgb24
SND_FMT="alaw" # formats: https://trac.ffmpeg.org/wiki/audio%20types

ffmpeg -i "$1" -f rawvideo -pixel_format $PIX_FMT -framerate $FRAME_RATE - \
| ffmpeg -f $SND_FMT -i - -af aecho=1.0:0.7:20:0.5 -f $SND_FMT - \
| ffmpeg -y -f rawvideo -video_size $VIDEO_SIZE -pixel_format $PIX_FMT -framerate $FRAME_RATE -i - "$2"
