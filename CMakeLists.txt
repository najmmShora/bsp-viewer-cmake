cmake_minimum_required(VERSION 3.15)
project(quake_bsp_viewer)

# Fix for older SDL2 CMake compatibility
set(CMAKE_POLICY_VERSION_MINIMUM 3.5)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)

# --- SDL2 ---
FetchContent_Declare(
    SDL2
    GIT_REPOSITORY https://github.com/libsdl-org/SDL.git
    GIT_TAG release-2.26.5
)
set(SDL_STATIC ON CACHE BOOL "Build static SDL library" FORCE)
set(SDL_SHARED OFF CACHE BOOL "Build shared SDL library" FORCE)
FetchContent_MakeAvailable(SDL2)

# --- GLM ---
FetchContent_Declare(
    glm
    GIT_REPOSITORY https://github.com/g-truc/glm.git
    GIT_TAG 0.9.9.8
)
FetchContent_MakeAvailable(glm)

# --- GLAD ---
set(GLAD_PROFILE "compatibility" CACHE STRING "OpenGL profile" FORCE)
set(GLAD_API "gl=3.3" CACHE STRING "API type/version pairs" FORCE)
set(GLAD_GENERATOR "c" CACHE STRING "Language to generate" FORCE)

FetchContent_Declare(
    glad
    GIT_REPOSITORY https://github.com/Dav1dde/glad.git
    GIT_TAG v0.1.36
)
FetchContent_MakeAvailable(glad)

# --- OpenGL ---
find_package(OpenGL REQUIRED)

# --- Project Executable ---
add_executable(quake_bsp_viewer 
    code/quake_main.cpp
)

target_compile_definitions(quake_bsp_viewer PRIVATE SDL_MAIN_HANDLED)

target_include_directories(quake_bsp_viewer PRIVATE 
    code
)

target_link_libraries(quake_bsp_viewer PRIVATE 
    SDL2::SDL2-static
    SDL2::SDL2main
    glm::glm
    glad
    OpenGL::GL
)

# Mac specific: SDL2 needs some frameworks
if(APPLE)
    target_link_libraries(quake_bsp_viewer PRIVATE 
        "-framework Cocoa"
        "-framework IOKit"
        "-framework CoreVideo"
        "-framework CoreAudio"
        "-framework AudioToolbox"
        "-framework ForceFeedback"
        "-framework Metal"
        "-framework Carbon"
    )
endif()
