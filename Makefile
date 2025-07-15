# ──────────────────────────────────────────────────────────────────────────────
# Project : OpenGL 3D Learning with GLM
# Makefile Version : 1.1
# Author  : drghost14
# ──────────────────────────────────────────────────────────────────────────────

#────────────────────────────────────────
# Compiler / Linker Settings
#────────────────────────────────────────
CXX       := g++
CXXFLAGS  := -m64 -O2 -Wall -std=c++23 -Iinclude
LDFLAGS   := -m64 -Llib \
              -lraylib -lenet -lgdi32 -lwinmm -lopengl32 \
              -lstdc++ -lstdc++exp \
              -Wl,-subsystem,console

#────────────────────────────────────────
# Parallelism
#────────────────────────────────────────
CORES     := $(shell nproc 2>/dev/null || echo 4)
JOBS      ?= $(CORES)

#────────────────────────────────────────
# Sources & Objects (don’t touch this)
#────────────────────────────────────────
SRCS      := $(wildcard \
               src/*.cpp \
               src/*/*.cpp \
               src/*/*/*.cpp \
               src/*/*/*/*.cpp \
               src/*/*/*/*/*.cpp)
OBJS      := $(SRCS:.cpp=.o)

#────────────────────────────────────────
# Executable
#────────────────────────────────────────
TARGET    := main.exe

#────────────────────────────────────────
# Phony Targets
#────────────────────────────────────────
.PHONY: all run pr pr_run strip clean

#────────────────────────────────────────
# Default: build + strip (.o removal)
#────────────────────────────────────────
all: $(TARGET) strip

#────────────────────────────────────────
# Run without rebuilding
#────────────────────────────────────────
run: $(TARGET)
	@echo "→ Running $(TARGET)…"
	@./$(TARGET)

#────────────────────────────────────────
# Parallel build (then strip)
#────────────────────────────────────────
pr:
	@echo "→ Building with $(JOBS) jobs…"
	@$(MAKE) -j$(JOBS) all

#────────────────────────────────────────
# Parallel build + run
#────────────────────────────────────────
pr_run: pr
	@echo "→ Launching $(TARGET)…"
	@./$(TARGET)

#────────────────────────────────────────
# Link step
#────────────────────────────────────────
$(TARGET): $(OBJS)
	@echo "→ Linking $@…"
	@$(CXX) $(CXXFLAGS) -o $@ $(OBJS) $(LDFLAGS)

#────────────────────────────────────────
# Compile step
#────────────────────────────────────────
%.o: %.cpp
	@echo "→ Compiling $<…"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

#────────────────────────────────────────
# Strip object files only
#────────────────────────────────────────
strip:
	@echo "→ Removing object files…"
	@rm -f $(OBJS)

#────────────────────────────────────────
# Full clean (objects + executable)
#────────────────────────────────────────
clean:
	@echo "→ Cleaning all build artifacts…"
	@rm -f $(OBJS) $(TARGET)
