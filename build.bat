@echo off
setlocal EnableDelayedExpansion

REM BSP Viewer Build Script
REM Usage: build.bat [--view=PATH] [--clean]

REM Configure
set RUN_AFTER_BUILD=false
set CLEAN_BUILD=false
set MAP_PATH=

REM Parse arguments
for %%a in (%*) do (
    set "arg=%%a"
    if "!arg:~0,7!"=="--view=" (
        set RUN_AFTER_BUILD=true
        set "MAP_PATH=!arg:~7!"
    )
    if "%%a"=="--clean" (
        set CLEAN_BUILD=true
    )
)

REM Clean build directory if requested
if "%CLEAN_BUILD%"=="true" (
    if exist build (
        rmdir /s /q build
    )
)

REM Check for ninja
where ninja >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Ninja is required. Please install ninja. 1>&2
    exit /b 1
)

REM Setup Visual Studio environment if VCVARS is set
if defined VCVARS (
    call "%VCVARS%" x64
)

REM Generate build files
cmake -G Ninja -B build -S .

echo --- Compiling ---
cmake --build build --parallel

REM Success check
if %errorlevel% equ 0 (
    echo --- Build Successful ---
    
    REM Optional run
    if "%RUN_AFTER_BUILD%"=="true" (
        .\build\quake_bsp_viewer.exe "%MAP_PATH%"
    )
) else (
    echo --- Build Failed ---
    exit /b 1
)

endlocal
