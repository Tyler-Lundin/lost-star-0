extends Node

var is_game_started: bool = false
var is_game_paused: bool = false

func start_game() -> void:
    is_game_started = true
    is_game_paused = false
    EventBus.game_started.emit()

func pause_game() -> void:
    if is_game_started and not is_game_paused:
        is_game_paused = true
        EventBus.game_paused.emit()

func resume_game() -> void:
    if is_game_started and is_game_paused:
        is_game_paused = false
        EventBus.game_resumed.emit() 