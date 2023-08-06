#!/bin/sh

# usage: ./interfere.sh <infile> <outfile> [max_flips]

MAX_FLIPS="8"
[ "$3" != "" ] && MAX_FLIPS="$3"

ffmpeg -i "$1" -f mpegts - \
  | python3 interference.py $MAX_FLIPS \
  | ffmpeg -y -err_detect ignore_err -f mpegts -i - "$2"
