#!/bin/bash

# BSP Viewer Build Script
# Usage: ./build.sh [--view=PATH] [--clean]

# Configure 
RUN_AFTER_BUILD=false
CLEAN_BUILD=false
MAP_PATH=""
for arg in "$@"; do
    case "$arg" in
        --view=*)
            RUN_AFTER_BUILD=true
            MAP_PATH="${arg#--view=}"
            ;;
        --clean) CLEAN_BUILD=true ;;
    esac
done

run_engine() {
    ./build/quake_bsp_viewer "$MAP_PATH"
}

if $CLEAN_BUILD; then
    rm -rf build
fi

if ! command -v ninja >/dev/null 2>&1; then
    echo "Error: Ninja is required. Please install ninja." >&2
    exit 1
fi

cmake -G Ninja -B build -S .

echo "--- Compiling ---"
cmake --build build --parallel

# Success check
if [ $? -eq 0 ]; then
    echo "--- Build Successful ---"
    
    # Optional run
    if $RUN_AFTER_BUILD; then
        run_engine
    fi
else
    echo "--- Build Failed ---"
    exit 1
fi
