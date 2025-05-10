extends Control

@onready var new_game_button = $VBoxContainer/NewGameButton
@onready var load_game_button = $VBoxContainer/LoadGameButton
@onready var settings_button = $VBoxContainer/SettingsButton
@onready var achievements_button = $VBoxContainer/AchievementsButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var title_label = $Title

func _ready() -> void:
	# Apply styles
	UIStyles.heading.call(title_label)
	UIStyles.primary_button.call(new_game_button)
	UIStyles.primary_button.call(load_game_button)
	UIStyles.secondary_button.call(settings_button)
	UIStyles.secondary_button.call(achievements_button)
	UIStyles.secondary_button.call(quit_button)
	
	# Connect button signals
	new_game_button.pressed.connect(_on_new_game_pressed)
	load_game_button.pressed.connect(_on_load_game_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	achievements_button.pressed.connect(_on_achievements_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_new_game_pressed() -> void:
	# Load the new game menu scene
	get_tree().change_scene_to_file("res://scenes/new_game_menu.tscn")

func _on_load_game_pressed() -> void:
	# TODO: Implement load game menu
	pass

func _on_settings_pressed() -> void:
	# TODO: Implement settings menu
	pass

func _on_achievements_pressed() -> void:
	# TODO: Implement achievements menu
	pass

func _on_quit_pressed() -> void:
	# Quit the game
	get_tree().quit() 