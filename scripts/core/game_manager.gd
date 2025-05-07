extends Node

# Game state
var is_game_started: bool = false
var is_game_paused: bool = false

func _ready() -> void:
    # Connect to EventBus signals
    EventBus.game_paused.connect(_on_game_paused)
    EventBus.game_resumed.connect(_on_game_resumed)
    
    EventBus.debug("GameManager initialized", "info")

func start_game() -> void:
    if is_game_started:
        EventBus.debug("Game already started", "warning")
        return
        
    is_game_started = true
    EventBus.game_started.emit()
    EventBus.debug("Game started", "info")

func pause_game() -> void:
    if not is_game_started or is_game_paused:
        return
        
    is_game_paused = true
    EventBus.game_paused.emit()
    EventBus.debug("Game paused", "info")

func resume_game() -> void:
    if not is_game_started or not is_game_paused:
        return
        
    is_game_paused = false
    EventBus.game_resumed.emit()
    EventBus.debug("Game resumed", "info")

func _on_game_paused() -> void:
    is_game_paused = true

func _on_game_resumed() -> void:
    is_game_paused = false

# Save/Load functions
func get_save_data() -> Dictionary:
    return {
        "is_game_started": is_game_started,
        "is_game_paused": is_game_paused
    }

func load_save_data(data: Dictionary) -> void:
    is_game_started = data.is_game_started
    is_game_paused = data.is_game_paused
    
    if is_game_paused:
        EventBus.game_paused.emit()
    else:
        EventBus.game_resumed.emit()
    
    EventBus.debug("Game state loaded", "info")
