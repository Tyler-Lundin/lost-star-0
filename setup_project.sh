#!/bin/bash

# Create main project directories
mkdir -p assets/{sprites,audio,fonts,themes}
mkdir -p scenes/{ui,game,widget}
mkdir -p scripts/{core,systems,utils}
mkdir -p resources/{configs,data}

# Create initial core script files
touch scripts/core/game_manager.gd
touch scripts/core/resource_manager.gd
touch scripts/core/time_manager.gd
touch scripts/core/save_manager.gd
touch scripts/core/event_bus.gd

# Create initial configuration files
touch resources/configs/game_config.json
touch resources/configs/resource_definitions.json
touch resources/configs/building_definitions.json
touch resources/configs/unit_definitions.json
touch resources/configs/age_progression.json

# Create initial scene files
touch scenes/ui/main_menu.tscn
touch scenes/game/main_game.tscn
touch scenes/widget/widget_mode.tscn

# Create .gitignore
cat > .gitignore << EOL
# Godot-specific ignores
.godot/
.import/
export.cfg
export_presets.cfg

# Imported translations (automatically generated from CSV files)
*.translation

# Mono-specific ignores
.mono/
data_*/
mono_crash.*.json

# System/tool-specific ignores
.DS_Store
._*
.Spotlight-V100
.Trashes
Icon?
ehthumbs.db
Thumbs.db

# Project-specific ignores
*.log
*.bak
*.swp
EOL

# Create initial README
cat > README.md << EOL
# ChronoCiv: Idle Ascension

A civilization that evolves across the ages—one idle moment at a time.

## Project Structure
- \`assets/\`: Game assets (sprites, audio, fonts, themes)
- \`scenes/\`: Godot scene files
- \`scripts/\`: GDScript source files
- \`resources/\`: Game configuration and data files

## Development Setup
1. Install Godot 4.x
2. Clone this repository
3. Open the project in Godot
4. Run the project

## Building
1. Open the project in Godot
2. Go to Project > Export
3. Select your target platform
4. Click Export Project

## Contributing
Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.

## License
This project is licensed under the MIT License - see the LICENSE file for details
EOL

# Create initial project.godot file
cat > project.godot << EOL
; Engine configuration file.
; It's best edited using the editor UI and not directly,
; since the parameters that go here are not all obvious.
;
; Format:
;   [section] ; section goes between []
;   param=value ; assign values to parameters

config_version=5

[application]

config/name="ChronoCiv: Idle Ascension"
run/main_scene="res://scenes/ui/main_menu.tscn"
config/features=PackedStringArray("4.2", "Forward Plus")
config/icon="res://icon.png"

[autoload]

GameManager="*res://scripts/core/game_manager.gd"
ResourceManager="*res://scripts/core/resource_manager.gd"
TimeManager="*res://scripts/core/time_manager.gd"
SaveManager="*res://scripts/core/save_manager.gd"
EventBus="*res://scripts/core/event_bus.gd"

[display]

window/size/viewport_width=1280
window/size/viewport_height=720
window/stretch/mode="canvas_items"

[rendering]

renderer/rendering_method="gl_compatibility"
EOL

echo "Project structure created successfully!" 