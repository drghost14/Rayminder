## ⏰ Rayminder — A Calming C++ Reminder App with Raylib

**Rayminder** is a lightweight C++ desktop application designed for timed reminders, blending clean visuals with ASMR-inspired ambiance. Built on **Raylib**, it offers gentle animations, pulsating shaders, and audio cues to create a serene reminder experience.

Whether you're scheduling personal tasks or showcasing technical elegance, Rayminder delivers a graceful fusion of graphics and functionality.

---

### ⚙️ Tech Stack

- 🎨 **Raylib** — simplified graphics and audio management  
- 🔷 **OpenGL** — dynamic effects and shader-driven visuals  
- 🔊 **AudioStream (MP3)** — soft ambient sound for ASMR feel  
- 🕰️ **C++ <chrono> & <ctime>** — precise reminder timing  
- 🧵 **std::thread** — concurrent reminder popups  
- 🔠 **Custom UI Effects** — pulsating visuals with math-driven styling  

---

### 💻 Run the App

> Ensure Raylib is properly included and `sound.mp3` is present in the `data/sounds/` folder.

1. **Clone the repository**
   ```bash
   git clone https://github.com/drghost14/rayminder.git
   ```

2. **Compile with g++ cmake**
   ```bash
   cmake --build build
   ```
   
3. **OR Compile with g++ makefile**
   ```bash
   make
   ```
   
4. **Launch the app**
   ```bash
   ./main.exe
   ```

4. **Add your reminders**
   Edit the predefined vector in `main()` like so:
   ```cpp
   vector<REMINDER> reminders = {
       {{14, 30, 0}, "Time for a break!"},
       {{14, 45, 0}, "Stretch and hydrate!"}
   };
   ```

---

### 🧠 App Structure

```text
rayminder/
├── src/
│   └── main.cpp         # Core reminder logic
├── data/
│   └── sounds/
│       └── sound.mp3    # Background audio for reminder popup
├── LICENSE              # MIT License
├── Makefile             # Make rules for MinGW
├── CMakeLists.txt       # Cmake rules for MinGW
└── README.md            # Project documentation
```

---

### 🧪 Sample Feature: Dynamic Reminder Window

- Circular breathing effect: `DrawCircle(...)` animated by sine wave  
- Smooth color transitions: `Color` fades and pulses using shader logic  
- Centered messages drawn with calculated text width  
- Background audio playback loop with `MusicStream`

---

### 🔐 License

Rayminder is released under the [MIT License](LICENSE) —  
you’re free to use, distribute, and remix this application for personal or educational purposes.  

> Attribution is appreciated. Raylib and other dependencies maintain their own license terms.

---

### 🎥 YouTube Showcase

This project is being featured in a multi-part video series  
on [CodeCanvas ASMR’s YouTube Channel](https://www.youtube.com/@CodeCanvasASMR)), highlighting  
its ASMR vibe and technical design.

