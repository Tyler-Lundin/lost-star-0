extends Node

signal save_completed
signal load_completed
signal save_failed(error: String)
signal load_failed(error: String)

# SaveSystem to handle saving and loading game state
const SAVE_DIR = "user://saves/"
const SAVE_EXTENSION = ".save"

func _ready() -> void:
	# Create save directory if it doesn't exist
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)

func save_game(save_name: String) -> void:
	var save_data = {
		"game_state": GameState.get_save_data(),
		"timestamp": Time.get_unix_time_from_system(),
		"version": "1.0.0"
	}
	
	var save_path = SAVE_DIR.path_join(save_name + SAVE_EXTENSION)
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	
	if save_file == null:
		save_failed.emit("Failed to open save file for writing")
		return
	
	save_file.store_var(save_data)
	save_file.close()
	save_completed.emit()

func load_game(save_name: String) -> void:
	var save_path = SAVE_DIR.path_join(save_name + SAVE_EXTENSION)
	
	if not FileAccess.file_exists(save_path):
		load_failed.emit("Save file does not exist")
		return
	
	var save_file = FileAccess.open(save_path, FileAccess.READ)
	
	if save_file == null:
		load_failed.emit("Failed to open save file for reading")
		return
	
	var save_data = save_file.get_var()
	save_file.close()
	
	if save_data == null:
		load_failed.emit("Failed to read save data")
		return
	
	GameState.load_save_data(save_data.game_state)
	load_completed.emit()

func get_save_files() -> Array:
	var save_files = []
	var dir = DirAccess.open(SAVE_DIR)
	
	if dir == null:
		return save_files
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(SAVE_EXTENSION):
			save_files.append(file_name.get_basename())
		file_name = dir.get_next()
	
	return save_files

func delete_save(save_name: String) -> bool:
	var save_path = SAVE_DIR.path_join(save_name + SAVE_EXTENSION)
	
	if not FileAccess.file_exists(save_path):
		return false
	
	var dir = DirAccess.open(SAVE_DIR)
	if dir == null:
		return false
	
	return dir.remove(save_path) == OK 