#!/usr/bin/env python3
import sys
import math
import os
import random

def ruin(data, max):
  n_flips = random.randint(0, max)
  n_repls = random.randint(0, math.sqrt(max) // 1) #random.randint(0, math.log2(len(data)) // 1)

  for n in range(n_flips):
    idx = random.randint(0, len(data) - 1)
    val = 1 << random.randint(0, 7)
    data[idx] ^= val

  for n in range(n_repls):
    idx = random.randint(0, len(data) - 1)
    data[idx] = random.randint(0, 0xFF)

with sys.stdin as f:
  max = 8
  if len(sys.argv) >= 2:
    max = int(sys.argv[1])
  first = True
  while True:
    data = bytearray(sys.stdin.buffer.read(16384))
    if data == b'':
      break

    if first:
      first = False
    else:
      ruin(data, max)

    sys.stdout.buffer.write(data)
