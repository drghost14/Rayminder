# ──────────────────────────────────────────────────────────────────────────────
# CMakeLists.txt for “OpenGL 3D Learning with GLM (Static ENet & Raylib)”
# Version 1.0
# Author  : Muhammad Hassnain Khichi (aka drghost)
# Converted from Makefile v1.5 to CMake
# ──────────────────────────────────────────────────────────────────────────────

cmake_minimum_required(VERSION 3.20)
project(OpenGL3DLearning
    VERSION 1.0
    LANGUAGES CXX
)

#────────────────────────────────────────
# 1. Compiler / Language Settings
#────────────────────────────────────────
# Use C++23, no compiler extensions
set(CMAKE_CXX_STANDARD       23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS     OFF)

# Default build type: Release (can override with -DCMAKE_BUILD_TYPE=Debug)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose Debug or Release" FORCE)
endif()

#────────────────────────────────────────
# 2. Include & Library Paths
#────────────────────────────────────────
# Project root: assume structure:
#  ├─ CMakeLists.txt
#  ├─ include/
#  ├─ lib/
#  └─ src/
include_directories(${CMAKE_SOURCE_DIR}/include)
link_directories   (${CMAKE_SOURCE_DIR}/lib)

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

#────────────────────────────────────────
# 5. Compile Options
#────────────────────────────────────────
# -m64         : 64-bit build
# -O2 / -O3    : optimization level
# -Wall        : enable all warnings
# you can append extra flags with CMAKE_CXX_FLAGS
target_compile_options(${PROJECT_NAME} PRIVATE
    -m64
    $<$<CONFIG:Debug>:-g -O0 -DDEBUG>
    $<$<CONFIG:Release>:-O2 -DNDEBUG>
    -Wall
)

#────────────────────────────────────────
# 6. Linker Options & Libraries
#────────────────────────────────────────
# Static link everything and include C++23 <print> support (libstdc++exp)
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
    opengl32
    ws2_32
  )
else()
  # On non-Windows you can drop subsystem flag and Windows-only libs
  target_link_libraries(${PROJECT_NAME} PRIVATE
    raylib
    enet
    stdc++exp
  )
endif()

#────────────────────────────────────────
# 7. Installation Rules
#────────────────────────────────────────
# Installs the executable into ${CMAKE_INSTALL_PREFIX}/bin
install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
)

#────────────────────────────────────────
# 8. Packaging Support (optional)
#────────────────────────────────────────
# include(CPack)
# set(CPACK_GENERATOR “TGZ;ZIP”)
# set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
# set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
# include(CPack)

#────────────────────────────────────────
# 9. Notes to Build & Install
#────────────────────────────────────────
# mkdir build && cd build
# cmake .. -DCMAKE_BUILD_TYPE=Release
# cmake --build . -- -j$(nproc)
# cmake --install . --prefix /usr/local

# You can switch to Debug via:
# cmake .. -DCMAKE_BUILD_TYPE=Debug
