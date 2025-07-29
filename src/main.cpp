// code here
#include <print> // c++23 feature

#include <string>
#include <vector>
#include <thread>

#include <ctime>
#include <chrono>
// GUI includes below
#include <raylib/raylib.h>
#include <raylib/raymath.h>
#include <cmath>

#define WIDTH  800
#define HEIGHT 600
#define FPS    60

using std::print, std::string, std::vector, std::thread;
using namespace std::chrono;

void StartWindow (const char *message);
// custom time struct FORMAT => hh/mm/ss
struct TIME
{
    int hours;
    int minutes;
    int seconds;

    bool operator== (const TIME &other) const
    {
        return hours == other.hours &&
        minutes == other.minutes &&
        seconds == other.seconds;
    }

    bool operator!= (const TIME &other) const
    {
        return !(*this == other);
    }
};

// reminder struct
struct REMINDER
{
    TIME   time;
    string message;
    bool   shown = false; // false by default
};

int main ()
{
    vector<REMINDER> reminders = 
    {
        {{14, 17, 0}, "HELLO ITS ME"},
        {{14, 17, 45}, "ITS ME AGAIN"},
        {{14, 18, 17}, "AGAIN ITS ME"}
    };

    while (true)
    {
        time_t now       = time (NULL);
        tm *local        = localtime (&now);
        TIME currentTime = {local -> tm_hour,
                            local -> tm_min,
                            local -> tm_sec};

        for (auto &itr : reminders)
        {
            if (!itr.shown && currentTime == itr.time)
            {
                thread (StartWindow, itr.message.c_str ()).detach ();
                print ("{}\n", itr.message);
                itr.shown = 1;
            }

            else if (itr.shown && currentTime != itr.time)
            {
                itr.shown = 0;
            }
        }
        std::this_thread::sleep_for (seconds (1)); // to prevent cpu over load
    }
}

void StartWindow (const char *message)
{
    SetConfigFlags (FLAG_MSAA_4X_HINT | FLAG_WINDOW_RESIZABLE);

    InitWindow (WIDTH, HEIGHT, "REMINDER APPLICATION");
    SetTargetFPS (FPS);

    InitAudioDevice ();
    Music bgMusic = LoadMusicStream ("data/sounds/sound.mp3");
    PlayMusicStream (bgMusic);

    Color bgColor = Color {245,
                        245,
                        250,
                        255};

    int textSize  = 36;
    int textWidth = MeasureText (message, textSize);

    while (!WindowShouldClose ())
    {
        UpdateMusicStream (bgMusic);
        float t      = GetTime ();
        float radius = 50 + 10 * sinf (t * 2.0f);
        
        float colorC = (((sinf (t) + 1) / 2) * 64) + 128;
        Color color  = {(unsigned char) colorC,
                        (unsigned char) colorC,
                        (unsigned char) colorC,
                        255};

        BeginDrawing ();
            ClearBackground (bgColor);
            // effects
            DrawCircle ((int) (GetScreenWidth () / 2),
                        (int) (GetScreenHeight () / 2),
                        radius,
                        color);
            // text
            DrawText (message,
                    (int) ((GetScreenWidth () - textWidth) / 2),
                    (int) (GetScreenHeight () / 2),
                    textSize,
                    DARKGRAY);

        EndDrawing ();
    }

    UnloadMusicStream (bgMusic);
    CloseAudioDevice ();
    CloseWindow ();
}
