extends Node

signal speed_changed(new_speed: float)

const INPUT_MAP_PATH = "res://resources/config/input_map.json"
var input_map: Dictionary = {}

func _ready() -> void:
    _load_input_map()
    _setup_input_actions()

func _load_input_map() -> void:
    if FileAccess.file_exists(INPUT_MAP_PATH):
        var file = FileAccess.open(INPUT_MAP_PATH, FileAccess.READ)
        var json = JSON.new()
        var error = json.parse(file.get_as_text())
        if error == OK:
            input_map = json.get_data()
        else:
            push_error("Failed to parse input map JSON: " + json.get_error_message())
    else:
        push_error("Input map file not found at: " + INPUT_MAP_PATH)

func _setup_input_actions() -> void:
    for action_name in input_map:
        var key = input_map[action_name]["key"]
        if not InputMap.has_action(action_name):
            InputMap.add_action(action_name)
        var event = InputEventKey.new()
        event.keycode = OS.find_keycode_from_string(key)
        InputMap.action_add_event(action_name, event)

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("speed_1x"):
        speed_changed.emit(1.0)
    elif event.is_action_pressed("speed_2x"):
        speed_changed.emit(2.0)
    elif event.is_action_pressed("speed_5x"):
        speed_changed.emit(5.0) 