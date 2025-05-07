extends Node

# Event signals for game systems
signal game_started
signal game_paused
signal game_resumed
signal game_saved
signal game_loaded

# Resource signals
signal resource_changed(resource_type: String, amount: float)
signal resource_capacity_changed(resource_type: String, capacity: float)

# Time signals
signal time_advanced(delta: float)
signal age_changed(new_age: String)
signal age_progress_changed(progress: float)

# Building signals
signal building_constructed(building_id: String)
signal building_upgraded(building_id: String)
signal building_destroyed(building_id: String)

# Unit signals
signal unit_created(unit_id: String)
signal unit_assigned(unit_id: String, task_id: String)
signal unit_completed_task(unit_id: String, task_id: String)

# Task signals
signal task_created(task_id: String)
signal task_completed(task_id: String)
signal task_failed(task_id: String)

# Widget signals
signal widget_created
signal widget_destroyed
signal widget_updated

# Save/Load signals
signal save_started
signal save_completed
signal load_started
signal load_completed
signal save_error(error_message: String)
signal load_error(error_message: String)

# Debug signals
signal debug_message(message: String)
signal debug_warning(message: String)
signal debug_error(message: String)

func _init() -> void:
	# Ensure this node is not destroyed when changing scenes
	process_mode = Node.PROCESS_MODE_ALWAYS

func _ready() -> void:
	# Connect to the tree_exiting signal to handle cleanup
	tree_exiting.connect(_on_tree_exiting)

func _on_tree_exiting() -> void:
	# Disconnect all signals when the node is being destroyed
	for signal_info in get_signal_list():
		var signal_name = signal_info["name"]
		var connections = get_signal_connection_list(signal_name)
		for connection in connections:
			disconnect(signal_name, connection["callable"])

# Helper function to emit debug messages
func debug(message: String, level: String = "info") -> void:
	match level:
		"info":
			debug_message.emit(message)
		"warning":
			debug_warning.emit(message)
		"error":
			debug_error.emit(message)
