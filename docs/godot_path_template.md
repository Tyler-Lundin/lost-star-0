# Godot Path Configuration Template

This template file shows how to configure the Godot executable path for your system. Copy this file and rename it to `godot_path.md` with your specific path.

## Windows Path Template
```powershell
# PowerShell
$env:GODOT_PATH = "C:\Path\To\Your\Godot\Godot_v4.4.1-stable_win64.exe"

# CMD
set GODOT_PATH=C:\Path\To\Your\Godot\Godot_v4.4.1-stable_win64.exe
```

## Linux/WSL Path Template
```bash
# Linux/WSL
export GODOT_PATH=/mnt/c/Path/To/Your/Godot/Godot_v4.4.1-stable_win64.exe
```

## Usage
After setting the path, you can use the provided scripts:
- `run.ps1` for Windows
- `run.sh` for Linux/WSL

Example:
```bash
# Windows
.\run.ps1 -Scene "res://scenes/game/main_game.tscn" -Debug

# Linux/WSL
./run.sh "res://scenes/game/main_game.tscn" debug
```

## Note
Make sure to:
1. Update the path to match your Godot installation location
2. Use the correct version number in the path
3. Use forward slashes (/) for Linux/WSL paths
4. Use backslashes (\) for Windows paths
5. Include the full path including the executable name 