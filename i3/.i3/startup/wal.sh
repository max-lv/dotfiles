#!/usr/bin/env sh

wal -n -i $1
feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"