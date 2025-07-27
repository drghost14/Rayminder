## 🎨 CodeCanvas — A Visual Studio Code Template for C++ Graphics & Networking

**CodeCanvas** is a curated C++ starter kit designed specifically for **Visual Studio Code** users on Windows. It wraps together powerful technologies—graphics, networking, and input handling—into a flexible, clean setup that accelerates development for interactive applications, games, and real-time tools.

---

### ⚙️ Built On

- 🖼️ **Raylib**            — simplifies graphics, window creation, and input
- 📐 **GLM**               — modern C++ mathematics library for graphics applications
- 🌐 **ENet**              — lightweight UDP-based networking
- 🎮 **OpenGL (via GLAD)** — for modern GPU rendering
- 🧰 **MinGW**             — compiler and linker (make sure it’s installed)
- 📄 **Makefile**          — build logic for MinGW
- 🛠️ **CMake**             — build logic for MinGW / MSVC
- 🧠 **VS Code Tasks**     — one-click build & clean

---

### 📁 Folder Overview

```text
codecanvas/
├── .vscode/          # VS Code tasks for build/clean
├── include/
│   ├── enet/         # ENet networking headers
│   ├── raylib/       # Raylib headers
│   ├── glad/         # OpenGL loader headers
│   ├── KHR/          # Khronos headers (e.g., khrplatform.h)
│   └── glm/          # Math library for vectors, matrices, transforms
├── lib/              # DLLs and libraries for linking
├── src/
│   └── main.cpp      # Starter source file (currently empty)
├── Makefile          # Build rules for MinGW         OPTION A
└── CMakeLists.txt    # Build rules for MinGW / MSVC  OPTION B
```

### 🧪 Quick Start Guide

1. **Clone the repository:**
   ```bash
   git clone https://github.com/drghost14/codecanvas.git
   ```
2. **Ensure MinGW and make are installed and added to your system PATH.**

3. **Open the folder in Visual Studio Code.**

4. **Build the project:**
   - Use `Ctrl + Shift + B` to trigger the pre-configured "Build Project" task.
   - Or run `make` manually from the terminal.

5. **Clean the project:**
   - Use the "Clean Project" task or run:
     ```bash
     make clean
     ```

---

### 🧠 What’s Included in `lib/`

- `raylib.dll`: Runtime dynamic library for Raylib (used only with dynamic linking)
- `libraylibdll.a`: Import library for Raylib’s DLL
- `libraylib.a`: Static library (used in this template)

> 🔧 This template defaults to **static linking** with `libraylib.a`, meaning `raylib.dll` is not required at runtime.

---

### 🛠️ Test Code Snippet

```cpp
#include "raylib/raylib.h"
#include "glad/glad.h"

int main() {
    InitWindow(800, 600, "Hello CodeCanvas!");
    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(RAYWHITE);
        DrawText("Your template is ready to roll!", 250, 280, 20, GRAY);
        EndDrawing();
    }
    CloseWindow();
    return 0;
}
```

---

### 📄 License

CodeCanvas is released under the [MIT License](LICENSE), ensuring it’s free and open for both personal and commercial use. Attribution is appreciated but not required.

