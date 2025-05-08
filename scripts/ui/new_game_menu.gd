extends Control

@onready var civ_name_input = $VBoxContainer/CivNameInput
@onready var difficulty_option = $VBoxContainer/DifficultyOption
@onready var starting_age_option = $VBoxContainer/StartingAgeOption
@onready var game_speed_option = $VBoxContainer/GameSpeedOption
@onready var auto_save_option = $VBoxContainer/AutoSaveOption
@onready var start_button = $VBoxContainer/StartButton
@onready var back_button = $VBoxContainer/BackButton
@onready var title_label = $VBoxContainer/Title

func _ready() -> void:
	# Apply styles
	UIStyles.heading.call(title_label)
	UIStyles.primary_button.call(start_button)
	UIStyles.secondary_button.call(back_button)
	
	# Connect button signals
	start_button.pressed.connect(_on_start_button_pressed)
	back_button.pressed.connect(_on_back_button_pressed)
	
	# Set default values
	civ_name_input.text = "New Civilization"
	difficulty_option.selected = 1  # Normal difficulty
	starting_age_option.selected = 0  # Stone Age
	game_speed_option.selected = 1  # Normal speed
	auto_save_option.selected = 1  # Every 5 minutes

func _on_start_button_pressed() -> void:
	# Validate input
	if civ_name_input.text.strip_edges().is_empty():
		# TODO: Show error message
		return
	
	# Initialize new game state
	GameState.initialize_new_game({
		"civ_name": civ_name_input.text.strip_edges(),
		"difficulty": difficulty_option.selected,
		"starting_age": starting_age_option.selected,
		"game_speed": game_speed_option.selected,
		"auto_save_interval": _get_auto_save_interval()
	})
	
	# Load the main game scene
	get_tree().change_scene_to_file("res://scenes/main_game.tscn")

func _on_back_button_pressed() -> void:
	# Return to main menu
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _get_auto_save_interval() -> int:
	match auto_save_option.selected:
		0: return 0  # Disabled
		1: return 300  # 5 minutes
		2: return 900  # 15 minutes
		3: return 1800  # 30 minutes
		_: return 300  # Default to 5 minutes 