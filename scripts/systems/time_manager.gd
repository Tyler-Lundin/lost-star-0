extends Node

var current_year: int = 0
var current_age: String = "Stone Age"
var time_scale: float = 1.0

func set_time_scale(scale: float) -> void:
    time_scale = scale
    Engine.time_scale = scale

func advance_time(delta: float) -> void:
    if GameManager.is_game_started and not GameManager.is_game_paused:
        current_year += 1
        EventBus.time_advanced.emit(delta) 