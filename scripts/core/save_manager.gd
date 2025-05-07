extends Node

const SAVE_DIRECTORY: String = "user://saves/"
const SAVE_EXTENSION: String = ".save"
const AUTO_SAVE_INTERVAL: float = 300.0  # 5 minutes

var current_save_name: String = ""
var auto_save_timer: float = 0.0

func _ready() -> void:
    # Create save directory if it doesn't exist
    if not DirAccess.dir_exists_absolute(SAVE_DIRECTORY):
        DirAccess.make_dir_absolute(SAVE_DIRECTORY)
    
    # Connect to EventBus signals
    EventBus.game_started.connect(_on_game_started)
    EventBus.game_saved.connect(_on_game_saved)
    EventBus.game_loaded.connect(_on_game_loaded)
    
    EventBus.debug("SaveManager initialized", "info")

func _process(delta: float) -> void:
    if current_save_name.is_empty():
        return
        
    # Handle auto-save
    auto_save_timer += delta
    if auto_save_timer >= AUTO_SAVE_INTERVAL:
        auto_save_timer = 0.0
        auto_save()

func save_game(save_name: String) -> bool:
    if save_name.is_empty():
        EventBus.debug("Invalid save name", "error")
        return false
        
    current_save_name = save_name
    var save_data = _collect_save_data()
    
    var save_path = SAVE_DIRECTORY + save_name + SAVE_EXTENSION
    var save_file = FileAccess.open(save_path, FileAccess.WRITE)
    
    if save_file == null:
        EventBus.debug("Failed to open save file: " + save_path, "error")
        return false
        
    save_file.store_var(save_data)
    save_file.close()
    
    EventBus.game_saved.emit(save_name)
    EventBus.debug("Game saved: " + save_name, "info")
    return true

func load_game(save_name: String) -> bool:
    if save_name.is_empty():
        EventBus.debug("Invalid save name", "error")
        return false
        
    var save_path = SAVE_DIRECTORY + save_name + SAVE_EXTENSION
    var save_file = FileAccess.open(save_path, FileAccess.READ)
    
    if save_file == null:
        EventBus.debug("Failed to open save file: " + save_path, "error")
        return false
        
    var save_data = save_file.get_var()
    save_file.close()
    
    if save_data == null:
        EventBus.debug("Invalid save data", "error")
        return false
        
    current_save_name = save_name
    _apply_save_data(save_data)
    
    EventBus.game_loaded.emit(save_name)
    EventBus.debug("Game loaded: " + save_name, "info")
    return true

func auto_save() -> void:
    if current_save_name.is_empty():
        return
        
    var auto_save_name = current_save_name + "_autosave"
    save_game(auto_save_name)

func get_save_list() -> Array:
    var saves = []
    var dir = DirAccess.open(SAVE_DIRECTORY)
    
    if dir == null:
        EventBus.debug("Failed to open save directory", "error")
        return saves
        
    dir.list_dir_begin()
    var file_name = dir.get_next()
    
    while file_name != "":
        if not dir.current_is_dir() and file_name.ends_with(SAVE_EXTENSION):
            saves.append(file_name.trim_suffix(SAVE_EXTENSION))
        file_name = dir.get_next()
        
    return saves

func _collect_save_data() -> Dictionary:
    return {
        "game_manager": GameManager.get_save_data(),
        "resource_manager": ResourceManager.get_save_data(),
        "time_manager": TimeManager.get_save_data(),
        "save_timestamp": Time.get_unix_time_from_system()
    }

func _apply_save_data(data: Dictionary) -> void:
    if data.has("game_manager"):
        GameManager.load_save_data(data.game_manager)
    if data.has("resource_manager"):
        ResourceManager.load_save_data(data.resource_manager)
    if data.has("time_manager"):
        TimeManager.load_save_data(data.time_manager)

func _on_game_started() -> void:
    current_save_name = ""
    auto_save_timer = 0.0

func _on_game_saved(save_name: String) -> void:
    # Additional save-related logic can be added here
    pass

func _on_game_loaded(save_name: String) -> void:
    # Additional load-related logic can be added here
    pass
