#!/bin/bash

GODOT="/mnt/c/Users/Tyler/Godot/Godot_v4.4.1-stable_win64.exe"
ARGS=("--path" "." "--no-window")

if [ ! -z "$1" ]; then
    ARGS+=("--scene" "$1")
fi

if [ "$2" == "debug" ]; then
    ARGS+=("--debug")
fi

if [ "$2" == "test" ]; then
    ARGS+=("--test")
fi

if [ "$2" == "profile" ]; then
    ARGS+=("--profiling")
fi

"$GODOT" "${ARGS[@]}" 