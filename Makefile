#────────────────────────────────────────
# Compiler / Linker
CXX       := g++
CXXFLAGS  := -m64 -O2 -Wall -std=c++23 -Iinclude
LDFLAGS := -m64 -Llib \
            -lraylib -lenet -lgdi32 -lwinmm -lopengl32 \
            -lstdc++ -lstdc++exp \
            -Wl,-subsystem,console

#────────────────────────────────────────
# Parallelism
# Detect number of CPU cores (nproc on MSYS2; fallback to 4)
CORES     := $(shell nproc 2>/dev/null || echo 4)
JOBS      ?= $(CORES)

#────────────────────────────────────────
# Sources & Objects
SRCS := $(wildcard src/*.cpp src/*/*.cpp src/*/*/*.cpp src/*/*/*/*/cpp)
OBJS := $(SRCS:.cpp=.o)

#────────────────────────────────────────
# Output
TARGET    := main.exe

#────────────────────────────────────────
.PHONY: all pr pr_run strip clean package package-run

# Default: single-threaded build
all: $(TARGET)
	@$(MAKE) strip

# Parallel build
pr:
	@echo "→ Building with $(JOBS) jobs…"
	@$(MAKE) -j$(JOBS) all

# Parallel build + run
pr_run: pr
	@echo "→ Launching $(TARGET)…"
	@./$(TARGET)

# Link step
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS) $(LDFLAGS)

# Compile step
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Strip object files (cleanup)
strip:
	@echo "→ Stripping object files…"
	@rm -f $(OBJS)

# Remove everything
clean:
	@echo "→ Cleaning everything…"
	@rm -f $(OBJS) $(TARGET)
	@rm -rf $(PACKAGE_DIR)
