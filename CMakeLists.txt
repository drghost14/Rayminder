# ──────────────────────────────────────────────────────────────────────────────
# CMakeLists.txt for “OpenGL 3D Learning with GLM (Static ENet & Raylib)”
# Version 1.0
# Author  : Muhammad Hassnain Khichi (aka drghost)
# Converted from Makefile v1.5 to CMake
# ──────────────────────────────────────────────────────────────────────────────

cmake_minimum_required(VERSION 3.20)
project(main
    VERSION 1.0
    LANGUAGES CXX
)

#────────────────────────────────────────
# 1. Compiler / Language Settings
#────────────────────────────────────────
set(CMAKE_CXX_STANDARD       23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS     OFF)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose Debug or Release" FORCE)
endif()

# Place the final executable in the project root
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR})

#────────────────────────────────────────
# 2. Include & Library Paths
#────────────────────────────────────────
# assume structure:
# ├─ CMakeLists.txt
# ├─ include/
# ├─ lib/
# └─ src/
# Use target scopes rather than global include_directories / link_directories

#────────────────────────────────────────
# 3. Gather Sources
#────────────────────────────────────────
file(GLOB_RECURSE SRCS
    "${CMAKE_SOURCE_DIR}/src/*.cpp"
)

#────────────────────────────────────────
# 4. Define Executable
#────────────────────────────────────────
add_executable(${PROJECT_NAME} ${SRCS})

# scoped include & link dirs
target_include_directories(${PROJECT_NAME}
    PRIVATE
        ${CMAKE_SOURCE_DIR}/include
)
target_link_directories(${PROJECT_NAME}
    PRIVATE
        ${CMAKE_SOURCE_DIR}/lib
)

#────────────────────────────────────────
# 5. Compile Options
#────────────────────────────────────────
target_compile_options(${PROJECT_NAME} PRIVATE
    -m64
    $<$<CONFIG:Debug>:-g -O0 -DDEBUG>
    $<$<CONFIG:Release>:-O2 -DNDEBUG>
    -Wall
)

#────────────────────────────────────────
# 6. Linker Options & Libraries
#────────────────────────────────────────
if(WIN32)
  target_link_options(${PROJECT_NAME} PRIVATE
    -m64
    -static
    -static-libstdc++
    -static-libgcc
    -Wl,-subsystem,console
  )
  target_link_libraries(${PROJECT_NAME} PRIVATE
    raylib
    enet
    stdc++exp
    gdi32
    winmm
    ws2_32
  )
else()
  target_link_libraries(${PROJECT_NAME} PRIVATE
    raylib
    enet
    stdc++exp
  )
endif()

#────────────────────────────────────────
# 7. Installation Rules
#────────────────────────────────────────
install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
)

#────────────────────────────────────────
# 8. Packaging Support (optional)
#────────────────────────────────────────
# include(CPack)
# set(CPACK_GENERATOR "TGZ;ZIP")
# set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
# set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
# include(CPack)

#────────────────────────────────────────
# 9. Notes to Build & Install
#────────────────────────────────────────
# mkdir build && cd build
# cmake .. -DCMAKE_BUILD_TYPE=Release
# cmake --build .
# cmake --install . --prefix /usr/local
#
# To switch to Debug:
# cmake .. -DCMAKE_BUILD_TYPE=Debug
