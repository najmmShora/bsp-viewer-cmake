# Quake BSP Viewer (CMake Version)

Forked from [danqua Quake BSP Viewer](https://github.com/danqua/bsp-viewer)

![QuakeStart](resources/quake_start.jpg)

This viewer allows you to revisit original Quake (1996) maps. It is extreamly fast and only performs so many draw calls of how many textures are used in a single map. It features lightmaps and animated skies as well, what a lot of repositories on github don't do. The code is written in C++ and OpenGL 3.3.

There is also a small video that shows the viewer in action.
[https://www.youtube.com/watch?v=GT7dP5C2cZM](https://www.youtube.com/watch?v=GT7dP5C2cZM)

## Building

This project uses CMake.  Make sure you have:
- CMake
- Ninja
- C++ Compiler (GCC/Clang/MSVC)

On **macOS and Linux** simply run [build.sh](build.sh) to generate and build the project.

On Windows, you'll need to run [build.bat](build.bat) via one of the following ways:
- Launch the *Visual Studio Developer PowerShell*, navigate to this project root and execute `./build.bat`
- Create an environment variable `VCVARS` that points to your **Visual Studio** `vcvarsall.bat`, and then simply double click on `build.bat`.

## Controls

+ W - Move Forward
+ S - Move Backward
+ A - Strafe Left
+ D - Strafe Right
+ E - Move Upwards
+ Q - Move Downwards
+ LShift - Increase Speed

## References

+ [https://github.com/id-Software/Quake](https://github.com/id-Software/Quake)
+ [https://www.gamers.org/dEngine/quake/spec/quake-spec34/](https://www.gamers.org/dEngine/quake/spec/quake-spec34/)