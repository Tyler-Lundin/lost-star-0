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