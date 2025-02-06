#!/bin/bash

if command -v nu 2>&1 >/dev/null
then
	nu -c 'sys mem | get available'
	exit 0
fi

awk '/MemAvailable/ {printf "%.2f GiB", $2/1024/1024}' /proc/meminfo
