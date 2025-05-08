extends Node

# Game state signals
signal game_started
signal game_paused
signal game_resumed
signal game_saved
signal game_loaded

# Time signals
signal time_advanced(delta: float)
signal age_changed(new_age: String)

# Resource signals
signal resource_changed(resource_type: String, amount: float)
signal resource_capacity_changed(resource_type: String, capacity: float) 