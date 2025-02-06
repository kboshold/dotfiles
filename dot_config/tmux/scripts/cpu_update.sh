#!/bin/bash

TMP_FILE=/tmp/tmux_cpu_usage_persistent

# Otherwise, compute the CPU usage using awk and /proc/stat
awk '{
  u = $2 + $4;
  t = $2 + $4 + $5;
  if (NR == 1) {
    u1 = u; t1 = t;
  } else {
    printf "%.2f\n", (u - u1) * 100 / (t - t1);
  }
}' <(grep "cpu " /proc/stat) <(sleep 3; grep "cpu " /proc/stat) > "$TMP_FILE"
