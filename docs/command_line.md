# Command Line Operations

## Running the Game

### Basic Run
```bash
# Windows (PowerShell/CMD)
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --run

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --run
```

### Run with Debug Output
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --run --debug

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --run --debug
```

### Run with Specific Scene
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --run --scene res://scenes/game/main_game.tscn

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --run --scene res://scenes/game/main_game.tscn
```

## Testing

### Run Unit Tests
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --run --test

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --run --test
```

### Run Specific Test
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --run --test --test-name "TestName"

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --run --test --test-name "TestName"
```

## Performance Testing

### Run with Performance Monitor
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --run --debug --profiling

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --run --debug --profiling
```

### Run with Memory Profiling
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --run --debug --memory-profiling

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --run --debug --memory-profiling
```

## Export and Build

### Export Game
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --export "Windows Desktop" "build/game.exe"

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --export "Windows Desktop" "build/game.exe"
```

### Build Headless Server
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --export "Windows Server" "build/server.exe"

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --export "Windows Server" "build/server.exe"
```

## Development Tools

### Check GDScript
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --check-only

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --check-only
```

### Generate Documentation
```bash
# Windows
"G:\Godot\Godot_v4.4.1-stable_win64.exe" --path . --no-window --doctool docs/generated

# Linux/WSL
/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe --path . --no-window --doctool docs/generated
```

## Common Options

- `--path .` : Specifies the project path
- `--no-window` : Runs without opening the editor window
- `--run` : Runs the game
- `--debug` : Enables debug output
- `--test` : Runs tests
- `--profiling` : Enables performance profiling
- `--memory-profiling` : Enables memory profiling
- `--export` : Exports the game
- `--check-only` : Checks GDScript without running
- `--doctool` : Generates documentation

## Environment Variables

```bash
# Set Godot path for easier command execution
# Windows (PowerShell)
$env:GODOT_PATH = "G:\Godot\Godot_v4.4.1-stable_win64.exe"

# Windows (CMD)
set GODOT_PATH=G:\Godot\Godot_v4.4.1-stable_win64.exe

# Linux/WSL
export GODOT_PATH=/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe
```

Then you can use:
```bash
$GODOT_PATH --path . --no-window --run
```

## Automation Scripts

### Windows (PowerShell)
```powershell
# run.ps1
param(
    [string]$Scene = "",
    [switch]$Debug,
    [switch]$Test,
    [switch]$Profile
)

$godot = "G:\Godot\Godot_v4.4.1-stable_win64.exe"
$args = @("--path", ".", "--no-window")

if ($Scene) {
    $args += @("--scene", $Scene)
}

if ($Debug) {
    $args += "--debug"
}

if ($Test) {
    $args += "--test"
}

if ($Profile) {
    $args += "--profiling"
}

& $godot $args
```

### Linux/WSL (Bash)
```bash
# run.sh
#!/bin/bash

GODOT="/mnt/g/Godot/Godot_v4.4.1-stable_win64.exe"
ARGS=("--path" "." "--no-window")

if [ ! -z "$1" ]; then
    ARGS+=("--scene" "$1")
fi

if [ "$2" == "debug" ]; then
    ARGS+=("--debug")
fi

if [ "$2" == "test" ]; then
    ARGS+=("--test")
fi

if [ "$2" == "profile" ]; then
    ARGS+=("--profiling")
fi

"$GODOT" "${ARGS[@]}"
```

Usage:
```bash
# Windows
.\run.ps1 -Scene "res://scenes/game/main_game.tscn" -Debug

# Linux/WSL
./run.sh "res://scenes/game/main_game.tscn" debug
``` 