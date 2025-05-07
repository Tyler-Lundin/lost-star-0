🏙️ Game Title (Working):
"ChronoCiv: Idle Ascension"
A civilization that evolves across the ages—one idle moment at a time.

🎮 Core Concept
A city-builder + idle evolution game where your civilization grows from primitive tribal to futuristic AI society through slow, continuous progression—with a widget-style UI that players can leave in the corner of their desktop.

Think of it like:

Idle Clicker + Civ Progression (but very slow, on purpose)

Main Game = Focused play (tasks/quests/research boosts)

Widget Mode = Passive slow growth + aesthetic timeline vibe

🧠 Key Features
🕹 Main Game Window (Fullscreen or Mobile-style UI)
Tasks/Quests: Hunt, farm, build, research, war, trade, etc.

Age Progression Tree: Stone → Bronze → Iron → Medieval → Industrial → Digital → Space

Unlock Units/Buildings per Age

Soft Resets: Prestige into alternate timelines (boosts future runs)

🪟 Widget Mode (Idle Companion)
Small floating window (MacOS/Windows overlay or mini viewport inside game)

Displays:

Current age

Passive resource growth

Progress bar to next age

A few mini animated pixel-art citizens doing era-appropriate stuff (fun flavor)

Optional "Micro Interactions" every X minutes (click to double idle speed for 1 min)

🧬 Mechanics
🏗 Age Advancement
Each Age unlocks new:

Buildings

Workers/Units

Tasks

Resource Types (e.g., mana in magic age, data in AI age)

Progress bar to new Age fills slowly over real-time + task input.

⏱ Time-Based Layers
Online Boosts: Actively playing speeds up tech discovery and building.

Offline Simulation: Slower, but constant.

Widget Mode: Even slower, but still ticking with minimal UI.

📈 Progression Curve
SLOW early growth by design (rewards patience)

Exponential scaling later (big jumps, new world types)

Optional settings:

"Slow Lane" (pure idle)

"Active Lane" (tasks to boost progress)

🔁 Prestige Loop / Legacy Systems
Rebirth from the ashes of a fallen civ

Keep certain buildings or units through ages

Unlocks new parallel timelines (sci-fi, post-apoc, fantasy)

🎨 Art & Feel
Pixel Art (clean and scalable for widget and full game)

Widget window has "ant farm" vibes—zoomed out but alive

Background music shifts subtly per age (optional toggle for quiet idle use)

🔧 Technical Breakdown (Godot-Oriented)
Scene system for Age UI, Widget UI, and Task UI

Signal-driven task engine for idle & active boosts

Persistent save system with real-world timestamp comparison for offline progress

Widget mode built as a resizable ViewportContainer anchored to screen corner

Data-driven age config (JSON or Resources per era)

🧪 Twists & Ideas to Explore Later
Weather/natural disaster systems

Age-specific "Great People" or "Wonders"

World Map mode (zoom out to interact with other civs)

"Mini-Wars" (autobattle idle or player-intervened micro RTS events)