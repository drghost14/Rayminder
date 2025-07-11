#────────────────────────────────────────
# Compiler / Linker
CXX      := g++
CXXFLAGS := -m64 -O2 -Wall -Iinclude
LDFLAGS  := -m64 -Llib -lraylib -lenet -lgdi32 -lwinmm -lopengl32 -lstdc++ \
            -Wl,-subsystem,console   # force console entry point

#────────────────────────────────────────
# Sources & Objects
SRCS := $(wildcard src/*.cpp src/*/*.cpp)
OBJS := $(SRCS:.cpp=.o)

#────────────────────────────────────────
# Output
TARGET := main.exe

#────────────────────────────────────────
.PHONY: all run clean

all: $(TARGET)
	@echo "→ Stripping object files…"
	@rm -f $(OBJS)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS) $(LDFLAGS)

# pattern rule for any .cpp → .o
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

run: $(TARGET)
	@rm -f $(OBJS)
	@.\$(TARGET)

clean:
	@echo "→ Cleaning everything…"
	@rm -f $(OBJS) $(TARGET)