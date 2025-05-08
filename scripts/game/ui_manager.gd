extends Control

# UI Manager to handle UI interactions and updates
class_name UIManager

@onready var food_label = $ResourcePanel/VBoxContainer/FoodLabel
@onready var wood_label = $ResourcePanel/VBoxContainer/WoodLabel
@onready var stone_label = $ResourcePanel/VBoxContainer/StoneLabel
@onready var population_label = $ResourcePanel/VBoxContainer/PopulationLabel
@onready var age_label = $ResourcePanel/VBoxContainer/AgeLabel
@onready var game_time_label = $ResourcePanel/VBoxContainer/GameTimeLabel

@onready var save_button = $SaveLoadPanel/VBoxContainer/SaveButton
@onready var load_button = $SaveLoadPanel/VBoxContainer/LoadButton
@onready var pause_button = $SaveLoadPanel/VBoxContainer/PauseButton

func _ready() -> void:
	# Connect signals
	await get_tree().process_frame  # Wait for autoloads to be ready
	GameState.resource_changed.connect(_on_resource_changed)
	GameState.time_advanced.connect(_on_time_advanced)
	
	# Connect button signals
	save_button.pressed.connect(_on_save_button_pressed)
	load_button.pressed.connect(_on_load_button_pressed)
	pause_button.pressed.connect(_on_pause_button_pressed)
	
	# Initial UI update
	_update_all_labels()

func _update_all_labels() -> void:
	food_label.text = "Food: %.1f" % GameState.get_resource("food")
	wood_label.text = "Wood: %.1f" % GameState.get_resource("wood")
	stone_label.text = "Stone: %.1f" % GameState.get_resource("stone")
	population_label.text = "Population: %.1f" % GameState.get_resource("population")
	age_label.text = "Age: %s" % GameState.get_current_age().capitalize()
	game_time_label.text = "Time: %.1f" % GameState.get_game_time()

func _on_resource_changed(resource_type: String, amount: float) -> void:
	match resource_type:
		"food":
			food_label.text = "Food: %.1f" % amount
		"wood":
			wood_label.text = "Wood: %.1f" % amount
		"stone":
			stone_label.text = "Stone: %.1f" % amount
		"population":
			population_label.text = "Population: %.1f" % amount

func _on_time_advanced(delta: float) -> void:
	game_time_label.text = "Time: %.1f" % GameState.get_game_time()

func _on_save_button_pressed() -> void:
	var save_name = "autosave"
	if GameState.get_node("SaveSystem").save_game(save_name):
		print("Game saved successfully")
	else:
		print("Failed to save game")

func _on_load_button_pressed() -> void:
	var save_name = "autosave"
	if GameState.get_node("SaveSystem").load_game(save_name):
		print("Game loaded successfully")
		_update_all_labels()
	else:
		print("Failed to load game")

func _on_pause_button_pressed() -> void:
	var is_paused = GameState.is_paused
	GameState.set_paused(!is_paused)
	pause_button.text = "Resume" if !is_paused else "Pause" 